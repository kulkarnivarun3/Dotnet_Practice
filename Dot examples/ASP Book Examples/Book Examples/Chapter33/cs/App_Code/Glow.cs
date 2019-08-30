using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace MyControls
{
public class Glow : ScriptControl
{
    private string _Text = "Glow Control";
    private string _BackgroundColor = "orange";

    public string Text
    {
        get { return _Text; }
        set { _Text = value; }
    }

    public string BackgroundColor
    {
        get { return _BackgroundColor; }
        set { _BackgroundColor = value; }
    }

    protected override IEnumerable<ScriptReference> GetScriptReferences()
    {
        ScriptReference sref = new ScriptReference("Glow.js");
        List<ScriptReference> colSRefs = new List<ScriptReference>();
        colSRefs.Add(sref);
        return colSRefs;
    }

    protected override IEnumerable<ScriptDescriptor> GetScriptDescriptors()
    {
        ScriptControlDescriptor des = new ScriptControlDescriptor("myControls.Glow", this.ClientID);
        des.AddProperty("text", _Text);
        des.AddProperty("backgroundColor", _BackgroundColor);
        List<ScriptDescriptor> colDes = new List<ScriptDescriptor>();
        colDes.Add(des);
        return colDes;        
    }
}
}