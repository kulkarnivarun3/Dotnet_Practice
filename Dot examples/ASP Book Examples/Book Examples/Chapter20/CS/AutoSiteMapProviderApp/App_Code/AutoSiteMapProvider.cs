using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Caching;

namespace AspNetUnleashed
{

    public class AutoSiteMapProvider : StaticSiteMapProvider
    {
        private SiteMapNode _rootNode;
        private static List<string> _excluded = new List<string>();
        private List<string> _dependencies = new List<string>();

        /// <summary>
        /// These folder and pages won't be added
        /// to the Site Map
        /// </summary>
        static AutoSiteMapProvider()
        {
            _excluded.Add("app_code");
            _excluded.Add("app_data");
            _excluded.Add("app_themes");
            _excluded.Add("bin");
        }

        /// <summary>
        /// Return the root node of the Site Map
        /// </summary>
        protected override SiteMapNode GetRootNodeCore()
        {
            return BuildSiteMap();
        }

        /// <summary>
        /// Where all of the work of building the Site Map happens
        /// </summary>
        public override SiteMapNode BuildSiteMap()
        {
            // Only allow the Site Map to be created by a single thread
            lock (this)
            {

                // Attempt to get Root Node from Cache
                HttpContext context = HttpContext.Current;
                _rootNode = (SiteMapNode)context.Cache["RootNode"];
                if (_rootNode == null)
                {
                    // Clear current Site Map
                    Clear();

                    // Create root node
                    string folderUrl = HttpRuntime.AppDomainAppVirtualPath;
                    string defaultUrl = folderUrl + "/Default.aspx";
                    _rootNode = new SiteMapNode(this, folderUrl, defaultUrl, "Home");
                    AddNode(_rootNode);

                    // Create child nodes
                    AddChildNodes(_rootNode);
                    _dependencies.Add(HttpRuntime.AppDomainAppPath);
                    
                    // Add root node to cache with file dependencies
                    CacheDependency fileDependency = new CacheDependency(_dependencies.ToArray());
                    context.Cache.Insert("RootNode", _rootNode, fileDependency);
                }
                return _rootNode;
            }
        }

        /// <summary>
        /// Add child folders and pages to the Site Map
        /// </summary>
        private void AddChildNodes(SiteMapNode parentNode)
        {

            AddChildFolders(parentNode);
            AddChildPages(parentNode);
        }

        /// <summary>
        /// Add child folders to the Site Map
        /// </summary>
        /// <param name="parentNode"></param>
        private void AddChildFolders(SiteMapNode parentNode)
        {
            HttpContext context = HttpContext.Current;
            string parentFolderPath = context.Server.MapPath(parentNode.Key);
            DirectoryInfo folderInfo = new DirectoryInfo(parentFolderPath);

            // Get sub folders
            DirectoryInfo[] folders = folderInfo.GetDirectories();
            foreach (DirectoryInfo folder in folders)
            {
                if (!_excluded.Contains(folder.Name.ToLower()))
                {
                    string folderUrl = parentNode.Key + "/" + folder.Name;
                    SiteMapNode folderNode = new SiteMapNode(this, folderUrl, null, GetName(folder.Name));
                    AddNode(folderNode, parentNode);
                    AddChildNodes(folderNode);
                    _dependencies.Add(folder.FullName);
                }
            }
        }

        /// <summary>
        /// Add child pages to the Site Map
        /// </summary>
        private void AddChildPages(SiteMapNode parentNode)
        {
            HttpContext context = HttpContext.Current;
            string parentFolderPath = context.Server.MapPath(parentNode.Key);
            DirectoryInfo folderInfo = new DirectoryInfo(parentFolderPath);

            FileInfo[] pages = folderInfo.GetFiles("*.aspx");
            foreach (FileInfo page in pages)
            {
                if (!_excluded.Contains(page.Name.ToLower()))
                {
                    string pageUrl = parentNode.Key + "/" + page.Name;
                    if (String.Compare(pageUrl, _rootNode.Url, true) !=0)
                    {
                        SiteMapNode pageNode = new SiteMapNode(this, pageUrl, pageUrl, GetName(page.Name));
                        AddNode(pageNode, parentNode);
                    }
                }
            }
        }

        /// <summary>
        /// Fix the name of the page or folder
        /// by removing the extension and replacing
        /// underscores with spaces
        /// </summary>
        private string GetName(string name)
        {
            name = Path.GetFileNameWithoutExtension(name);
            return name.Replace("_", " ");
        }



    }
}
