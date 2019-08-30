using System;
using System.Collections.Specialized;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Caching;

namespace AspNetUnleashed
{


    /// <summary>
    /// Summary description for SqlSiteMapProvider
    /// </summary>
    public class SqlSiteMapProvider : StaticSiteMapProvider
    {

        private bool _isInitialized = false;
        private string _connectionString;
        private SiteMapNode _rootNode;

        public override void Initialize(string name, NameValueCollection attributes)
        {
            if (_isInitialized)
                return;

            base.Initialize(name, attributes);

            string connectionStringName = attributes["connectionStringName"];
            if (String.IsNullOrEmpty(connectionStringName))
                throw new Exception("You must provide a connectionStringName attribute");

            _connectionString = WebConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
            if (String.IsNullOrEmpty(_connectionString))
                throw new Exception("Could not find connection string " + connectionStringName);

            _isInitialized = true;
        }

        protected override SiteMapNode GetRootNodeCore()
        {
            return BuildSiteMap();
        }

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
                    HttpContext.Current.Trace.Warn("Loading from database");

                    // Clear current Site Map
                    Clear();

                    // Load the database data
                    DataTable tblSiteMap = GetSiteMapFromDB();

                    // Get the root node
                    _rootNode = GetRootNode(tblSiteMap);
                    AddNode(_rootNode);

                    // Build the child nodes 
                    BuildSiteMapRecurse(tblSiteMap, _rootNode);

                    // Add root node to cache with database dependency
                    SqlCacheDependency sqlDepend = new SqlCacheDependency("SiteMapDB", "SiteMap");
                    context.Cache.Insert("RootNode", _rootNode, sqlDepend);
                }
                return _rootNode;
            }
        }


        private DataTable GetSiteMapFromDB()
        {
            string selectCommand = "SELECT Id,ParentId,Url,Title,Description FROM SiteMap";
            SqlDataAdapter dad = new SqlDataAdapter(selectCommand, _connectionString);
            DataTable tblSiteMap = new DataTable();
            dad.Fill(tblSiteMap);
            return tblSiteMap;
        }


        private SiteMapNode GetRootNode(DataTable siteMapTable)
        {
            DataRow[] results = siteMapTable.Select("ParentId IS NULL");
            if (results.Length == 0)
                throw new Exception("No root node in database");
            DataRow rootRow = results[0];
            return new SiteMapNode(this, rootRow["Id"].ToString(), rootRow["url"].ToString(), rootRow["title"].ToString(), rootRow["description"].ToString());
        }

        private void BuildSiteMapRecurse(DataTable siteMapTable, SiteMapNode parentNode)
        {
            DataRow[] results = siteMapTable.Select("ParentId=" + parentNode.Key);
            foreach (DataRow row in results)
            {
                SiteMapNode node = new SiteMapNode(this, row["Id"].ToString(), row["url"].ToString(), row["title"].ToString(), row["description"].ToString());
                AddNode(node, parentNode);
                BuildSiteMapRecurse(siteMapTable, node);
            }
        }

    }
}