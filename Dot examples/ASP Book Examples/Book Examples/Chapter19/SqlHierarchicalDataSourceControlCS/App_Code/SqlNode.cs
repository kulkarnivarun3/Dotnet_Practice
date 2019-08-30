using System;
using System.Collections.Generic;
using System.Data;
using System.ComponentModel;
using System.Web.UI;

namespace AspNetUnleashed
{

    /// <summary>
    /// Represents a node (row) from the database
    /// </summary>
    public class SqlNode : IHierarchyData, ICustomTypeDescriptor
    {

        private SqlHierarchicalDataSourceView _owner;
        private DataRow _row;

        public SqlNode(SqlHierarchicalDataSourceView owner, DataRow row)
        {
            _owner = owner;
            _row = row;
        }

        /// <summary>
        /// Does the current database row have child rows?
        /// </summary>
        public bool HasChildren
        {
            get
            {
                string filter = String.Format("{0}={1}", _owner.DataParentKeyName, _row[_owner.DataKeyName]);
                DataRow[] childRows = _owner.Data.Select(filter);

                return childRows.Length > 0;
            }
        }


        /// <summary>
        /// Returns the DataRow
        /// </summary>
        public object Item
        {

            get { return _row; }

        }

        /// <summary>
        /// A unique identifier for the row
        /// </summary>
        public string Path
        {

            get { return _row[_owner.DataKeyName].ToString(); }

        }


        /// <summary>
        /// The Type is used in switching logic
        /// </summary>
        public string Type
        {

            get { return "SqlNode"; }

        }

        /// <summary>
        /// The ToString() method is called to show
        /// the value of a row (we default to showing
        /// the value of the first column)
        /// </summary>
        public override string ToString()
        {
            return _row[0].ToString();
        }

        /// <summary>
        /// Get child rows of current row
        /// </summary>
        public IHierarchicalEnumerable GetChildren()
        {

            string filter = string.Format("{0}={1}", _owner.DataParentKeyName, _row[_owner.DataKeyName]);
            DataRow[] childRows = _owner.Data.Select(filter);

            SqlHierarchicalEnumerable en = new SqlHierarchicalEnumerable();
            foreach (DataRow row in childRows)
                en.Add(new SqlNode(_owner, row));
            return en;
        }


        /// <summary>
        /// Get Parent Row of current row
        /// </summary>
        public IHierarchyData GetParent()
        {
            string filter = string.Format("{0}={1}", _owner.DataKeyName, _row[_owner.DataParentKeyName]);
            DataRow[] parentRows = _owner.Data.Select(filter);

            if (parentRows.Length > 0)
                return new SqlNode(_owner, parentRows[0]);
            else
                return null;

        }

        /// <summary>
        /// Get the list of properties supported by the SqlNode
        /// </summary>
        public PropertyDescriptorCollection GetProperties()
        {
            List<PropertyDescriptor> props = new List<PropertyDescriptor>();
            foreach (DataColumn col in _owner.Data.Columns)
                props.Add(new SqlNodePropertyDescriptor(col.ColumnName));
            return new PropertyDescriptorCollection(props.ToArray());
        }


        // The following properties and methods are required by the
        // ICustomTypeDescriptor interface but are not implemented

        public System.ComponentModel.AttributeCollection GetAttributes()
        {
            throw new Exception("Not implemented.");
        }

        public string GetClassName()
        {
            throw new Exception("Not implemented.");
        }

        public string GetComponentName()
        {
            throw new Exception("Not implemented.");
        }

        public TypeConverter GetConverter()
        {
            throw new Exception("Not implemented.");
        }

        public EventDescriptor GetDefaultEvent()
        {
            throw new Exception("Not implemented.");
        }

        public PropertyDescriptor GetDefaultProperty()
        {
            throw new Exception("Not implemented.");
        }

        public object GetEditor(Type editorBaseType)
        {
            throw new Exception("Not implemented.");
        }

        public EventDescriptorCollection GetEvents(Attribute[] attributes)
        {
            throw new Exception("Not implemented.");
        }

        public EventDescriptorCollection GetEvents()
        {
            throw new Exception("Not implemented.");
        }

        public PropertyDescriptorCollection GetProperties(Attribute[] attributes)
        {
            throw new Exception("Not implemented.");
        }

        public object GetPropertyOwner(PropertyDescriptor pd)
        {
            throw new Exception("Not implemented.");
        }

    }
}