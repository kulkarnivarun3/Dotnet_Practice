using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Hosting;
using System.IO;
using System.Web;

namespace Superexpert
{

    /// <summary>
    /// Summary description for SqlVirtualFile
    /// </summary>
    public class SqlVirtualFile : VirtualFile
    {

        public SqlVirtualFile(string virtualPath)
            : base(virtualPath) { }


        public override Stream Open()
        {
            // Get content from database
            string content = VirtualFiles.FileContentSelect(this.VirtualPath);

            // return results as stream
            MemoryStream mem = new MemoryStream();
            StreamWriter writer = new StreamWriter(mem);
            writer.Write(content);
            writer.Flush();
            mem.Seek(0, SeekOrigin.Begin);
            return mem;
        }

        public string Content
        {
            get
            {
                return VirtualFiles.FileContentSelect(this.VirtualPath);
            }
        }


    }
}