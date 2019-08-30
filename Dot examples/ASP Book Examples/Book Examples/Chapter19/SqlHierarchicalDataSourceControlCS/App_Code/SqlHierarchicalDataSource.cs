using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace AspNetUnleashed
{

    /// <summary>
    /// Extends SqlDataSource control to support hierarchical database data
    /// </summary>
    public class SqlHierarchicalDataSource : SqlDataSource, IHierarchicalDataSource
    {
        private string _dataKeyName;
        private string _dataParentKeyName;


        public event EventHandler DataSourceChanged;


        /// <summary>
        /// The database table primary key
        /// </summary>
        public string DataKeyName
        {
            get { return _dataKeyName; }
            set { _dataKeyName = value; }
        }

        /// <summary>
        /// The database table parent id
        /// </summary>
        public string DataParentKeyName
        {
            get { return _dataParentKeyName; }
            set { _dataParentKeyName = value; }
        }

        /// <summary>
        /// Return hierarchical data
        /// </summary>
        public HierarchicalDataSourceView GetHierarchicalView(string viewPath)
        {
            return new SqlHierarchicalDataSourceView(this, viewPath);
        }

    }
}