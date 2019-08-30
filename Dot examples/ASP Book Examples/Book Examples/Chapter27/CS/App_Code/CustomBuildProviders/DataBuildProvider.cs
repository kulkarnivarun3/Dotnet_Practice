using System;
using System.Collections.Generic;
using System.Web.Compilation;
using System.CodeDom;
using System.Xml;
using System.IO;
using System.Web.Hosting;

namespace AspNetUnleashed
{

    public class DataBuildProvider : BuildProvider
    {
        string _className;

        public override void GenerateCode(AssemblyBuilder ab)
        {
            // Load the XML file
            XmlDocument xmlData = new XmlDocument();
            xmlData.Load(HostingEnvironment.MapPath(this.VirtualPath));

            // Generate code from XML document
            CodeCompileUnit dataCode = GetDataCode(xmlData);

            // Add the code
            ab.AddCodeCompileUnit(this, dataCode);
        }

        private CodeCompileUnit GetDataCode(XmlDocument xmlData)
        {
            // Add class
            _className = Path.GetFileNameWithoutExtension(this.VirtualPath);
            CodeTypeDeclaration dataType = new CodeTypeDeclaration(_className);
            dataType.IsPartial = true;

            // Add constructor
            AddConstructor(dataType);

            // Add properties
            AddProperties(dataType, xmlData);

            // Add Select method
            AddSelect(dataType, xmlData);

            // Add Select with conString overload
            AddSelectConString(dataType, xmlData);

            // Create namespace
            CodeNamespace dataNS = new CodeNamespace("Data");

            // Add class to namespace
            dataNS.Types.Add(dataType);

            // Create code unit
            CodeCompileUnit dataCode = new CodeCompileUnit();

            // Add namespace to code unit
            dataCode.Namespaces.Add(dataNS);

            // Add default namespaces
            dataNS.Imports.Add(new CodeNamespaceImport("System"));

            return dataCode;
        }

        private void AddConstructor(CodeTypeDeclaration dataType)
        {
            // Add default constructor method
            CodeConstructor classConstructor = new CodeConstructor();
            classConstructor.Attributes = MemberAttributes.Public;
            dataType.Members.Add(classConstructor);
        }

        private void AddProperties(CodeTypeDeclaration dataType, XmlDocument xmlData)
        {
            foreach (XmlElement el in xmlData.DocumentElement.ChildNodes)
            {
                string propName = el.Attributes["name"].Value;
                string propType = "System.String";
                if (el.HasAttribute("type"))
                    propType = el.Attributes["type"].Value;

                // Add backing field
                string propFieldName = "_" + propName;
                CodeMemberField field = new CodeMemberField(propType, propFieldName);
                dataType.Members.Add(field);

                // Add property
                CodeMemberProperty prop = new CodeMemberProperty();
                dataType.Members.Add(prop);

                prop.Name = propName;
                prop.Type = new CodeTypeReference(propType);
                prop.Attributes = MemberAttributes.Public;

                // Add Get
                CodeMethodReturnStatement getMethod = new CodeMethodReturnStatement();
                CodeFieldReferenceExpression refField = new CodeFieldReferenceExpression(new CodeThisReferenceExpression(), propFieldName);
                getMethod.Expression = refField;
                prop.GetStatements.Add(getMethod);

                // Add Set
                CodeAssignStatement setMethod = new CodeAssignStatement(new CodeFieldReferenceExpression(new CodeThisReferenceExpression(), propFieldName), new CodePropertySetValueReferenceExpression());
                prop.SetStatements.Add(setMethod);
            }
        }

        private void AddSelect(CodeTypeDeclaration dataType, XmlDocument xmlData)
        {
            // Create Select method
            CodeMemberMethod selectMethod = new CodeMemberMethod();
            selectMethod.Name = "Select";
            selectMethod.Attributes = MemberAttributes.Static | MemberAttributes.Public;
            selectMethod.Parameters.Add(new CodeParameterDeclarationExpression("System.Data.SqlClient.SqlConnection", "con"));
            CodeVariableReferenceExpression refCon = new CodeVariableReferenceExpression("con");
            AddSummaryComment(selectMethod, "Returns List of " + _className);

            // Specify return type
            CodeTypeReference refList = new CodeTypeReference("System.Collections.Generic.List", new CodeTypeReference[] { new CodeTypeReference(_className) });
            selectMethod.ReturnType = refList;

            // Add List collection for results
            CodeVariableDeclarationStatement initResults = new CodeVariableDeclarationStatement(refList, "results", new CodeObjectCreateExpression(refList));
            selectMethod.Statements.Add(initResults);
            CodeVariableReferenceExpression refResults = new CodeVariableReferenceExpression("results");

            // Add Command object
            CodeVariableDeclarationStatement initCmd = new CodeVariableDeclarationStatement("System.Data.SqlClient.SqlCommand", "cmd", new CodeObjectCreateExpression("System.Data.SqlClient.SqlCommand"));
            selectMethod.Statements.Add(initCmd);
            CodeVariableReferenceExpression refCmd = new CodeVariableReferenceExpression("cmd");
            CodeAssignStatement addCmdCon = new CodeAssignStatement(new CodePropertyReferenceExpression(refCmd, "Connection"), refCon);
            selectMethod.Statements.Add(addCmdCon);
            CodeVariableDeclarationStatement initCmdText = new CodeVariableDeclarationStatement(typeof(string), "cmdText", new CodePrimitiveExpression(GetCommandText(xmlData)));
            selectMethod.Statements.Add(initCmdText);
            CodeAssignStatement addCmdText = new CodeAssignStatement(new CodePropertyReferenceExpression(refCmd, "CommandText"), new CodeVariableReferenceExpression("cmdText"));
            selectMethod.Statements.Add(addCmdText);


            // Init SqlDataReader
            CodeMethodInvokeExpression cmdExec = new CodeMethodInvokeExpression(refCmd, "ExecuteReader");
            CodeVariableDeclarationStatement initReader = new CodeVariableDeclarationStatement("System.Data.SqlClient.SqlDataReader", "reader", cmdExec);
            selectMethod.Statements.Add(initReader);
            CodeVariableReferenceExpression refReader = new CodeVariableReferenceExpression("reader");

            // Create While Loop
            CodeVariableDeclarationStatement initCounter = new CodeVariableDeclarationStatement("System.Int32", "counter");
            selectMethod.Statements.Add(initCounter);
            CodeVariableReferenceExpression refLoopCounter = new CodeVariableReferenceExpression("counter");
            CodeAssignStatement loopInit = new CodeAssignStatement(refLoopCounter, new CodePrimitiveExpression(0));
            CodeMethodInvokeExpression loopTest = new CodeMethodInvokeExpression(refReader, "Read");
            CodeAssignStatement loopIncrement = new CodeAssignStatement(refLoopCounter, new CodeBinaryOperatorExpression(refLoopCounter, CodeBinaryOperatorType.Add, new CodePrimitiveExpression(1)));
            CodeIterationStatement loop = new CodeIterationStatement(loopInit, loopTest, loopIncrement);
            selectMethod.Statements.Add(loop);


            // Create object
            CodeVariableDeclarationStatement initRecord = new CodeVariableDeclarationStatement(_className, "record", new CodeObjectCreateExpression(_className));
            CodeVariableReferenceExpression refRecord = new CodeVariableReferenceExpression("record");
            loop.Statements.Add(initRecord);

            // Loop through properties
            foreach (XmlElement el in xmlData.DocumentElement.ChildNodes)
            {
                string propName = el.Attributes["name"].Value;
                string propType = "System.String";
                if (el.HasAttribute("type"))
                    propType = el.Attributes["type"].Value;
                CodeIndexerExpression refIndexer = new CodeIndexerExpression(refReader, new CodePrimitiveExpression(propName));
                CodeCastExpression castIt = new CodeCastExpression(propType, refIndexer);
                CodePropertyReferenceExpression refProp = new CodePropertyReferenceExpression(refRecord, propName);
                CodeAssignStatement assignProp = new CodeAssignStatement(refProp, castIt);
                loop.Statements.Add(assignProp);
            }

            // add record to collection
            CodeMethodInvokeExpression invokeAdd = new CodeMethodInvokeExpression(refResults, "Add", new CodeExpression[] { refRecord });
            loop.Statements.Add(invokeAdd);

            // Return results
            CodeMethodReturnStatement ret = new CodeMethodReturnStatement(refResults);
            selectMethod.Statements.Add(ret);

            // Add the Select method to the class
            dataType.Members.Add(selectMethod);
        }

        private void AddSelectConString(CodeTypeDeclaration dataType, XmlDocument xmlData)
        {
            // Create Select method
            CodeMemberMethod selectMethod = new CodeMemberMethod();
            selectMethod.Name = "Select";
            selectMethod.Attributes = MemberAttributes.Static | MemberAttributes.Public;
            selectMethod.Parameters.Add(new CodeParameterDeclarationExpression("System.String", "connectionStringName"));
            AddSummaryComment(selectMethod, "Returns List of " + _className);
            CodeVariableReferenceExpression refConStringName = new CodeVariableReferenceExpression("connectionStringName");

            // Specify return type
            CodeTypeReference refList = new CodeTypeReference("System.Collections.Generic.List", new CodeTypeReference[] { new CodeTypeReference(_className) });
            selectMethod.ReturnType = refList;

            // Add List collection for results
            CodeVariableDeclarationStatement initResults = new CodeVariableDeclarationStatement(refList, "results", new CodeObjectCreateExpression(refList));
            selectMethod.Statements.Add(initResults);
            CodeVariableReferenceExpression refResults = new CodeVariableReferenceExpression("results");

            // Get connection string setting
            CodeTypeReferenceExpression refConStrings = new CodeTypeReferenceExpression("System.Web.Configuration.WebConfigurationManager");
            CodePropertyReferenceExpression refPropConStrings = new CodePropertyReferenceExpression(refConStrings, "ConnectionStrings");
            CodeIndexerExpression conString = new CodeIndexerExpression(refPropConStrings, refConStringName);
            CodeVariableDeclarationStatement initConStringSetting = new CodeVariableDeclarationStatement("System.Configuration.ConnectionStringSettings", "conStringSettings", conString);
            selectMethod.Statements.Add(initConStringSetting);
            CodeVariableReferenceExpression refConStringSettings = new CodeVariableReferenceExpression("conStringSettings");

            // Get connection string
            CodePropertyReferenceExpression refPropConString = new CodePropertyReferenceExpression(refConStringSettings, "ConnectionString");
            CodeVariableDeclarationStatement initConString = new CodeVariableDeclarationStatement("System.String", "conString", refPropConString);
            selectMethod.Statements.Add(initConString);
            CodeVariableReferenceExpression refConString = new CodeVariableReferenceExpression("conString");

            // Create connection object
            CodeVariableDeclarationStatement initCon = new CodeVariableDeclarationStatement("System.Data.SqlClient.SqlConnection", "con", new CodeObjectCreateExpression("System.Data.SqlClient.SqlConnection"));
            selectMethod.Statements.Add(initCon);
            CodeVariableReferenceExpression refCon = new CodeVariableReferenceExpression("con");

            // Assign connection string
            CodeAssignStatement addConString = new CodeAssignStatement(new CodePropertyReferenceExpression(refCon, "ConnectionString"), refConString);
            selectMethod.Statements.Add(addConString);

            // Add Try
            CodeTryCatchFinallyStatement tryBlock = new CodeTryCatchFinallyStatement();
            selectMethod.Statements.Add(tryBlock);

            // Open Connection
            CodeMethodInvokeExpression conOpen = new CodeMethodInvokeExpression(refCon, "Open");
            tryBlock.TryStatements.Add(conOpen);

            // Call Select with connection
            CodeTypeReferenceExpression refMe = new CodeTypeReferenceExpression(_className);
            CodeMethodReferenceExpression refSelect = new CodeMethodReferenceExpression(refMe, "Select");
            CodeMethodInvokeExpression invokeSelect = new CodeMethodInvokeExpression(refSelect, new CodeExpression[] { refCon });

            // Assign results to local variable
            CodeAssignStatement assignResults = new CodeAssignStatement(refResults, invokeSelect);
            tryBlock.TryStatements.Add(assignResults);

            // Close Connection
            CodeMethodInvokeExpression conClose = new CodeMethodInvokeExpression(refCon, "Close");
            tryBlock.FinallyStatements.Add(conClose);

            // Return results
            CodeMethodReturnStatement ret = new CodeMethodReturnStatement(refResults);
            selectMethod.Statements.Add(ret);

            // Add the Select method to the class
            dataType.Members.Add(selectMethod);
        }

        private string GetCommandText(XmlDocument xmlData)
        {
            string tableName = xmlData.DocumentElement.Name;
            List<String> columns = new List<String>();
            foreach (XmlElement el in xmlData.DocumentElement.ChildNodes)
            {
                columns.Add(el.Attributes["name"].Value);
            }
            string columnList = String.Join(",", columns.ToArray());
            return String.Format("SELECT {0} FROM {1}", columnList, tableName);
        }

        private void AddSummaryComment(CodeTypeMember member, string comment)
        {
            member.Comments.Add(new CodeCommentStatement("<summary>" + comment + "</summary>", true));
        }

    }
}