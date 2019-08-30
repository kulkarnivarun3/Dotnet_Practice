using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace AspNetUnleashed
{

    /// <summary>
    /// Represents the data returned from database
    /// </summary>
    public class SqlHierarchicalDataSourceView : HierarchicalDataSourceView
    {
        private SqlHierarchicalDataSource _owner;
        private string _viewPath;
        private DataTable _data;

        public SqlHierarchicalDataSourceView(SqlHierarchicalDataSource owner, string viewPath)
        {
            _owner = owner;
            _viewPath = viewPath;
        }

        /// <summary>
        /// The DataTable which contains all rows from
        /// underlying database table
        /// </summary>
        public DataTable Data
        {
            get { return _data; }
        }

        /// <summary>
        /// We need to expose this for the SqlNodes
        /// </summary>
        public string DataKeyName
        {
            get { return _owner.DataKeyName; }
        }

        /// <summary>
        /// We need to expose this for the SqlNodes
        /// </summary>
        public string DataParentKeyName
        {
            get { return _owner.DataParentKeyName; }
        }

        /// <summary>
        /// Get the top-level rows (rows without parent rows)
        /// </summary>
        /// <returns></returns>
        public override IHierarchicalEnumerable Select()
        {
            // Verify DataKeyName and DataParentKeyName properties
            if (String.IsNullOrEmpty(DataKeyName))
                throw new Exception("You must set the DataKeyName property");
            if (String.IsNullOrEmpty(DataParentKeyName))
                throw new Exception("You must set the DataParentKeyName property");

            // Return DataView from SqlDataSource 
            if (_owner.DataSourceMode != SqlDataSourceMode.DataSet)
                throw new Exception("DataSourceMode must be set to DataSet");
            DataView view = (DataView)_owner.Select(DataSourceSelectArguments.Empty);
            _data = view.Table;

            // Get the root rows
            string filter = string.Format("{0} IS NULL", this.DataParentKeyName);
            DataRow[] rootRows = _data.Select(filter);

            // Build up the hierarchical collection
            SqlHierarchicalEnumerable en = new SqlHierarchicalEnumerable();
            foreach (DataRow row in rootRows)
                en.Add(new SqlNode(this, row));
            return en;
        }


    }
}