using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace MyControls
{
[TargetControlType(typeof(TextBox))]
public class HelpExtender: ExtenderControl
{
    private string _Text = "Help Text...";

    public string Text
    {
        get { return _Text; }
        set { _Text = value; }
    }

    protected override IEnumerable<ScriptReference> GetScriptReferences()
    {
        ScriptReference sref = new ScriptReference("~/HelpBehavior.js");
        List<ScriptReference> colSRefs = new List<ScriptReference>();
        colSRefs.Add(sref);
        return colSRefs;    
    }

    protected override IEnumerable<ScriptDescriptor> GetScriptDescriptors(Control targetControl)
    {
        ScriptControlDescriptor des = new ScriptControlDescriptor("myControls.HelpBehavior", TargetControlID);
        des.AddProperty("text", _Text);
        List<ScriptDescriptor> colDes = new List<ScriptDescriptor>();
        colDes.Add(des);
        return colDes;            
    }
}
}