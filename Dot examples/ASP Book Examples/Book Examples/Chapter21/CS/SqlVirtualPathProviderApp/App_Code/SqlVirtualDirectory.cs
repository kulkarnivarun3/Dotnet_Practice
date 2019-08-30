using System;
using System.Collections;
using System.Web.Hosting;
using System.Web;

namespace AspNetUnleashed
{

    public class SqlVirtualDirectory : VirtualDirectory
    {

        public SqlVirtualDirectory(string virtualPath) : base(virtualPath) { }


        public string AppPath
        {
            get { return VirtualPathUtility.ToAppRelative(VirtualPath); }
        }


        public override IEnumerable Children
        {
            get {return VirtualFiles.DirectorySelectChildren(VirtualPath); }
        }



        public override IEnumerable Directories
        {
            get { return VirtualFiles.DirectorySelectDirectories(VirtualPath); }
        }

        public override IEnumerable Files
        {
            get { return VirtualFiles.DirectorySelectFiles(VirtualPath); }
        }
    }
}