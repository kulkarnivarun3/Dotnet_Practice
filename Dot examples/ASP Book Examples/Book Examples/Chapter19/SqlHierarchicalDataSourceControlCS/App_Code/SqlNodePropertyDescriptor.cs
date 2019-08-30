using System;
using System.ComponentModel;
using System.Data;


namespace AspNetUnleashed
{

    /// <summary>
    /// Describes a property of a SqlNode
    /// </summary>
    public class SqlNodePropertyDescriptor : PropertyDescriptor
    {

        public SqlNodePropertyDescriptor(string name) : base(name, null) { }


        /// <summary>
        /// Return the value of a DataColumn represented by
        /// a particular SqlNode
        /// </summary>
        public override object GetValue(object component)
        {
            SqlNode node = (SqlNode)component;
            return ((DataRow)node.Item)[this.Name];
        }


        // Don't bother to implement any of the other methods or properties
        // of this class

        public override bool CanResetValue(object component)
        {
            throw new Exception("Not implemented.");
        }

        public override Type ComponentType
        {
            get { throw new Exception("Not implemented."); }
        }

        public override bool IsReadOnly
        {
            get { throw new Exception("Not implemented."); }
        }

        public override Type PropertyType
        {
            get { throw new Exception("Not implemented."); }
        }

        public override void ResetValue(object component)
        {
            throw new Exception("Not implemented.");
        }

        public override void SetValue(object component, object value)
        {
            throw new Exception("Not implemented.");
        }

        public override bool ShouldSerializeValue(object component)
        {
            throw new Exception("Not implemented.");
        }
    }
}