using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Superexpert.Controls
{


/// <summary>
/// Summary description for EntityDataSource
/// </summary>
public class EntityDataSource : ObjectDataSource
{

    protected override void OnInit(EventArgs e)
    {
        this.DataObjectTypeName = this.TypeName;
        this.ConflictDetection = ConflictOptions.CompareAllValues;
        this.OldValuesParameterFormatString = "oldEntity";

        if (String.IsNullOrEmpty(this.SelectMethod))
            this.SelectMethod = "Select";
        if (String.IsNullOrEmpty(this.SelectCountMethod))
            this.SelectCountMethod = "SelectCountCached";
        if (String.IsNullOrEmpty(this.InsertMethod))
            this.InsertMethod = "Insert";
        if (String.IsNullOrEmpty(this.UpdateMethod))
            this.UpdateMethod = "Update";
        if (String.IsNullOrEmpty(this.DeleteMethod))
            this.DeleteMethod = "Delete";                
    
        base.OnInit(e);
    }

}
}