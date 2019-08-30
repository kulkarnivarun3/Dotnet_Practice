using System;
using System.Web.UI;
using System.Collections;

namespace AspNetUnleashed
{

    /// <summary>
    /// Represents a collection of SqlNodes
    /// </summary>
    public class SqlHierarchicalEnumerable : ArrayList, IHierarchicalEnumerable
    {

        public SqlHierarchicalEnumerable() : base() { }

        public IHierarchyData GetHierarchyData(object enumeratedItem)
        {
            return enumeratedItem as IHierarchyData;
        }



    }
}