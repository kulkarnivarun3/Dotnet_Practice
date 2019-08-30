using System;
using System.Web.Compilation;
using System.CodeDom;
using System.IO;

namespace AspNetUnleashed
{
    public class SimpleBuildProvider : BuildProvider
    {
        public override void GenerateCode(AssemblyBuilder ab)
        {
            string fileName = Path.GetFileNameWithoutExtension(this.VirtualPath);
            string snippet = "public class " + fileName + @"
                {
                    public static void DoSomething(){} 
                }";
            ab.AddCodeCompileUnit(this, new CodeSnippetCompileUnit(snippet));
        }

    }
}