using System;
using System.CodeDom;
using System.Web.UI;
using System.ComponentModel;
using System.Web.Compilation;
using System.Xml;
using System.Web.Hosting;
using System.Web.Caching;

namespace AspNetUnleashed
{
    public class LookupExpressionBuilder : ExpressionBuilder
    {
        public override CodeExpression GetCodeExpression(BoundPropertyEntry entry, object parsedData, ExpressionBuilderContext context)
        {
            CodeTypeReferenceExpression refMe = new CodeTypeReferenceExpression(base.GetType());
            CodePrimitiveExpression expression = new CodePrimitiveExpression(entry.Expression);
            return new CodeMethodInvokeExpression(refMe, "GetEvalData", new CodeExpression[] { expression });
        }

        public override object EvaluateExpression(object target, BoundPropertyEntry entry, object parsedData, ExpressionBuilderContext context)
        {
            return GetEvalData(entry.Expression);
        }

        public override bool SupportsEvaluate
        {
            get
            {
                return true;
            }
        }

        public static string GetEvalData(string expression)
        {
            XmlDocument lookupDoc = (XmlDocument)HostingEnvironment.Cache["Lookup"];
            if (lookupDoc == null)
            {
                lookupDoc = new XmlDocument();
                string lookupFileName = HostingEnvironment.MapPath("~/Lookup.config");
                lookupDoc.Load(lookupFileName);
                CacheDependency fileDepend = new CacheDependency(lookupFileName);
                HostingEnvironment.Cache.Insert("Lookup", lookupDoc, fileDepend);
            }

            string search = String.Format("//add[@key='{0}']", expression);
            XmlNode match = lookupDoc.SelectSingleNode(search);
            if (match != null)
                return match.Attributes["value"].Value;
            return "[no match]";
        }

    }
}