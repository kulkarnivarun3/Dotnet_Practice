using System;
using System.Web;
using System.Web.Caching;
using System.Collections;
using System.Collections.Generic;
using System.Web.Hosting;

namespace AspNetUnleashed
{

    public class SqlVirtualPathProvider : VirtualPathProvider
    {
        /// <summary>
        /// Register VirtualPathProvider for the application
        /// </summary>
        public static void AppInitialize()
        {
            SqlVirtualPathProvider sqlProvider = new SqlVirtualPathProvider();
            HostingEnvironment.RegisterVirtualPathProvider(sqlProvider);
        }


        public SqlVirtualPathProvider() : base() { }

        /// <summary>
        /// Returns true when the file is a virtual file
        /// instead of a normal filesystem file
        /// </summary>
        private bool IsVirtualFile(string virtualPath)
        {
            String appVirtualPath = VirtualPathUtility.ToAppRelative(virtualPath);
            return !appVirtualPath.StartsWith("~/admin/", StringComparison.InvariantCultureIgnoreCase);
        }

        /// <summary>
        /// Returns true when a file exists
        /// </summary>
        public override bool FileExists(string virtualPath)
        {
            if (IsVirtualFile(virtualPath))
                return VirtualFiles.FileExists(virtualPath);
            else
                return Previous.FileExists(virtualPath);
        }

        /// <summary>
        /// Gets a SqlVirtualFile which corresponds
        /// to a file with a certain path
        /// </summary>
        public override VirtualFile GetFile(string virtualPath)
        {
            if (IsVirtualFile(virtualPath)) 
                return new SqlVirtualFile(virtualPath); 
            else
                return Previous.GetFile(virtualPath);
        }

        /// <summary>
        /// Returns true when a directory exists
        /// </summary>
        public override bool DirectoryExists(string virtualPath)
        {
            if (IsVirtualFile(virtualPath))
                return VirtualFiles.DirectoryExists(virtualPath);
            else
                return Previous.DirectoryExists(virtualPath);
        }

        /// <summary>
        /// Returns a SqlVirtualDirectory which corresponds
        /// to a virtual path
        /// </summary>
        public override VirtualDirectory GetDirectory(string virtualPath)
        {
            if (IsVirtualFile(virtualPath))
                return new SqlVirtualDirectory(virtualPath);
            else
                return Previous.GetDirectory(virtualPath);
        }

        /// <summary>
        /// Gets the SqlCacheDependency object for the VirtualFilesDB
        /// database
        /// </summary>
        public override CacheDependency GetCacheDependency(string virtualPath, IEnumerable virtualPathDependencies, DateTime utcStart)
        {
            if (IsVirtualFile(virtualPath))
                return new SqlCacheDependency("VirtualFiles", "VirtualFiles");
            else
                return Previous.GetCacheDependency(virtualPath, virtualPathDependencies, utcStart);
        }

    }
}