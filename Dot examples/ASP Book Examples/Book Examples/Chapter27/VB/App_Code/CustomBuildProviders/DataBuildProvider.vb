Imports System
Imports System.Collections.Generic
Imports System.Web.Compilation
Imports System.CodeDom
Imports System.Xml
Imports System.IO
Imports System.Web.Hosting

Namespace AspNetUnleashed

    Public Class DataBuildProvider
        Inherits BuildProvider

        Private _className As String

        Public Overrides Sub GenerateCode(ByVal ab As AssemblyBuilder)
            ' Load the XML file
            Dim xmlData As New XmlDocument()
            xmlData.Load(HostingEnvironment.MapPath(Me.VirtualPath))

            ' Generate code from XML document
            Dim dataCode As CodeCompileUnit = GetDataCode(xmlData)

            ' Add the code
            ab.AddCodeCompileUnit(Me, dataCode)
        End Sub

        Private Function GetDataCode(ByVal xmlData As XmlDocument) As CodeCompileUnit
            ' Add class
            _className = Path.GetFileNameWithoutExtension(Me.VirtualPath)
            Dim dataType As New CodeTypeDeclaration(_className)
            dataType.IsPartial = True

            ' Add constructor
            AddConstructor(dataType)

            ' Add properties
            AddProperties(dataType, xmlData)

            ' Add Select method
            AddSelect(dataType, xmlData)

            ' Add Select with conString overload
            AddSelectConString(dataType, xmlData)

            ' Create namespace
            Dim dataNS As New CodeNamespace("Data")

            ' Add class to namespace
            dataNS.Types.Add(dataType)

            ' Create code unit
            Dim dataCode As New CodeCompileUnit()

            ' Add namespace to code unit
            dataCode.Namespaces.Add(dataNS)

            ' Add default namespaces
            dataNS.Imports.Add(New CodeNamespaceImport("System"))

            Return dataCode
        End Function

        Private Sub AddConstructor(ByVal dataType As CodeTypeDeclaration)
            ' Add default constructor method
            Dim classConstructor As New CodeConstructor()
            classConstructor.Attributes = MemberAttributes.Public
            dataType.Members.Add(classConstructor)
        End Sub

        Private Sub AddProperties(ByVal dataType As CodeTypeDeclaration, ByVal xmlData As XmlDocument)
            For Each el As XmlElement In xmlData.DocumentElement.ChildNodes
                Dim propName As String = el.Attributes("name").Value
                Dim propType As String = "System.String"
                If el.HasAttribute("type") Then
                    propType = el.Attributes("type").Value
                End If

                ' Add backing field
                Dim propFieldName As String = "_" & propName
                Dim field As New CodeMemberField(propType, propFieldName)
                dataType.Members.Add(field)

                ' Add property
                Dim prop As New CodeMemberProperty()
                dataType.Members.Add(prop)

                prop.Name = propName
                prop.Type = New CodeTypeReference(propType)
                prop.Attributes = MemberAttributes.Public

                ' Add Get
                Dim getMethod As New CodeMethodReturnStatement()
                Dim refField As New CodeFieldReferenceExpression(New CodeThisReferenceExpression(), propFieldName)
                getMethod.Expression = refField
                prop.GetStatements.Add(getMethod)

                ' Add Set
                Dim setMethod As New CodeAssignStatement(New CodeFieldReferenceExpression(New CodeThisReferenceExpression(), propFieldName), New CodePropertySetValueReferenceExpression())
                prop.SetStatements.Add(setMethod)
            Next
        End Sub

        Private Sub AddSelect(ByVal dataType As CodeTypeDeclaration, ByVal xmlData As XmlDocument)
            ' Create Select method
            Dim selectMethod As New CodeMemberMethod()
            selectMethod.Name = "Select"
            selectMethod.Attributes = MemberAttributes.Static Or MemberAttributes.Public
            selectMethod.Parameters.Add(New CodeParameterDeclarationExpression("System.Data.SqlClient.SqlConnection", "con"))
            Dim refCon As New CodeVariableReferenceExpression("con")
            AddSummaryComment(selectMethod, "Returns List of " & _className)

            ' Specify return type
            Dim refList As New CodeTypeReference("System.Collections.Generic.List",New CodeTypeReference() {New CodeTypeReference(_className)})
            selectMethod.ReturnType = refList

            ' Add List collection for results
            Dim initResults As New CodeVariableDeclarationStatement(refList, "results", New CodeObjectCreateExpression(refList))
            selectMethod.Statements.Add(initResults)
            Dim refResults As New CodeVariableReferenceExpression("results")

            ' Add Command object
            Dim initCmd As New CodeVariableDeclarationStatement("System.Data.SqlClient.SqlCommand", "cmd", New CodeObjectCreateExpression("System.Data.SqlClient.SqlCommand"))
            selectMethod.Statements.Add(initCmd)
            Dim refCmd As New CodeVariableReferenceExpression("cmd")
            Dim addCmdCon As New CodeAssignStatement(New CodePropertyReferenceExpression(refCmd, "Connection"), refCon)
            selectMethod.Statements.Add(addCmdCon)
            Dim initCmdText As New CodeVariableDeclarationStatement(GetType(String), "cmdText", New CodePrimitiveExpression(GetCommandText(xmlData)))
            selectMethod.Statements.Add(initCmdText)
            Dim addCmdText As New CodeAssignStatement(New CodePropertyReferenceExpression(refCmd, "CommandText"), New CodeVariableReferenceExpression("cmdText"))
            selectMethod.Statements.Add(addCmdText)

            ' Init SqlDataReader
            Dim cmdExec As New CodeMethodInvokeExpression(refCmd, "ExecuteReader")
            Dim initReader As New CodeVariableDeclarationStatement("System.Data.SqlClient.SqlDataReader", "reader", cmdExec)
            selectMethod.Statements.Add(initReader)
            Dim refReader As New CodeVariableReferenceExpression("reader")

            ' Create While Loop
            Dim initCounter As New CodeVariableDeclarationStatement("System.Int32", "counter")
            selectMethod.Statements.Add(initCounter)
            Dim refLoopCounter As New CodeVariableReferenceExpression("counter")
            Dim loopInit As New CodeAssignStatement(refLoopCounter, New CodePrimitiveExpression(0))
            Dim loopTest As New CodeMethodInvokeExpression(refReader, "Read")
            Dim loopIncrement As New CodeAssignStatement(refLoopCounter, New CodeBinaryOperatorExpression(refLoopCounter, CodeBinaryOperatorType.Add, New CodePrimitiveExpression(1)))
            Dim codeLoop As New CodeIterationStatement(loopInit, loopTest, loopIncrement)
            selectMethod.Statements.Add(codeLoop)

            ' Create object
            Dim initRecord As New CodeVariableDeclarationStatement(_className, "record", New CodeObjectCreateExpression(_className))
            Dim refRecord As New CodeVariableReferenceExpression("record")
            codeLoop.Statements.Add(initRecord)

            ' Loop through properties
            For Each el As XmlElement In xmlData.DocumentElement.ChildNodes
                Dim propName As String = el.Attributes("name").Value
                Dim propType As String = "System.String"
                If el.HasAttribute("type") Then
                    propType = el.Attributes("type").Value
                End If
                Dim refIndexer As New CodeIndexerExpression(refReader, New CodePrimitiveExpression(propName))
                Dim castIt As New CodeCastExpression(propType, refIndexer)
                Dim refProp As New CodePropertyReferenceExpression(refRecord, propName)
                Dim assignProp As New CodeAssignStatement(refProp, castIt)
                codeLoop.Statements.Add(assignProp)
            Next

            ' add record to collection
            Dim invokeAdd As New CodeMethodInvokeExpression(refResults, "Add", New CodeExpression() {refRecord})
            codeLoop.Statements.Add(invokeAdd)

            ' Return results
            Dim ret As New CodeMethodReturnStatement(refResults)
            selectMethod.Statements.Add(ret)

            ' Add the Select method to the class
            dataType.Members.Add(selectMethod)
        End Sub

        Private Sub AddSelectConString(ByVal dataType As CodeTypeDeclaration, ByVal xmlData As XmlDocument)
            ' Create Select method
            Dim selectMethod As New CodeMemberMethod()
            selectMethod.Name = "Select"
            selectMethod.Attributes = MemberAttributes.Static Or MemberAttributes.Public
            selectMethod.Parameters.Add(New CodeParameterDeclarationExpression("System.String", "connectionStringName"))
            AddSummaryComment(selectMethod, "Returns List of " & _className)
            Dim refConStringName As New CodeVariableReferenceExpression("connectionStringName")

            ' Specify return type
            Dim refList As New CodeTypeReference("System.Collections.Generic.List", New CodeTypeReference() {New CodeTypeReference(_className)})
            selectMethod.ReturnType = refList

            ' Add List collection for results
            Dim initResults As New CodeVariableDeclarationStatement(refList, "results", New CodeObjectCreateExpression(refList))
            selectMethod.Statements.Add(initResults)
            Dim refResults As New CodeVariableReferenceExpression("results")

            ' Get connection string setting
            Dim refConStrings As New CodeTypeReferenceExpression("System.Web.Configuration.WebConfigurationManager")
            Dim refPropConStrings As New CodePropertyReferenceExpression(refConStrings, "ConnectionStrings")
            Dim conString As New CodeIndexerExpression(refPropConStrings, refConStringName)
            Dim initConStringSetting As New CodeVariableDeclarationStatement("System.Configuration.ConnectionStringSettings", "conStringSettings", conString)
            selectMethod.Statements.Add(initConStringSetting)
            Dim refConStringSettings As New CodeVariableReferenceExpression("conStringSettings")

            ' Get connection string
            Dim refPropConString As New CodePropertyReferenceExpression(refConStringSettings, "ConnectionString")
            Dim initConString As New CodeVariableDeclarationStatement("System.String", "conString", refPropConString)
            selectMethod.Statements.Add(initConString)
            Dim refConString As New CodeVariableReferenceExpression("conString")

            ' Create connection object
            Dim initCon As New CodeVariableDeclarationStatement("System.Data.SqlClient.SqlConnection", "con", New CodeObjectCreateExpression("System.Data.SqlClient.SqlConnection"))
            selectMethod.Statements.Add(initCon)
            Dim refCon As New CodeVariableReferenceExpression("con")

            ' Assign connection string
            Dim addConString As New CodeAssignStatement(New CodePropertyReferenceExpression(refCon, "ConnectionString"), refConString)
            selectMethod.Statements.Add(addConString)

            ' Add Try
            Dim TryBlock As New CodeTryCatchFinallyStatement()
            selectMethod.Statements.Add(TryBlock)

            ' Open Connection
            Dim conOpen As New CodeMethodInvokeExpression(refCon, "Open")
            TryBlock.TryStatements.Add(conOpen)

            ' Call Select with connection
            Dim refMe As New CodeTypeReferenceExpression(_className)
            Dim refSelect As New CodeMethodReferenceExpression(refMe, "Select")
            Dim invokeSelect As New CodeMethodInvokeExpression(refSelect, New CodeExpression() {refCon})

            ' Assign results to local variable
            Dim assignResults As New CodeAssignStatement(refResults, invokeSelect)
            TryBlock.TryStatements.Add(assignResults)

            ' Close Connection
            Dim conClose As New CodeMethodInvokeExpression(refCon, "Close")
            TryBlock.FinallyStatements.Add(conClose)

            ' Return results
            Dim ret As New CodeMethodReturnStatement(refResults)
            selectMethod.Statements.Add(ret)

            ' Add the Select method to the class
            dataType.Members.Add(selectMethod)
        End Sub

        Private Function GetCommandText(ByVal xmlData As XmlDocument) As String
            Dim tableName As String = xmlData.DocumentElement.Name
            Dim columns As New List(Of String)()
            For Each el As XmlElement In xmlData.DocumentElement.ChildNodes
                columns.Add(el.Attributes("name").Value)
            Next
            Dim columnList As String = String.Join(",", columns.ToArray())
            Return String.Format("SELECT {0} FROM {1}", columnList, tableName)
        End Function

        Private Sub AddSummaryComment(ByVal member As CodeTypeMember, ByVal comment As String)
            member.Comments.Add(New CodeCommentStatement("<summary>" & comment & "</summary>", True))
        End Sub

    End Class
End Namespace

