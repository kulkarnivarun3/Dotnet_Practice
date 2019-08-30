<%@ Control Language="C#" ClassName="Glow" %>
<%@ Implements Interface="System.Web.UI.IScriptControl" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

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

    public IEnumerable<ScriptReference> GetScriptReferences()
    {
        ScriptReference sref = new ScriptReference("Glow.js"); 
        List<ScriptReference> colSRefs = new List<ScriptReference>();
        colSRefs.Add( sref );
        return colSRefs;
    }

    public IEnumerable<ScriptDescriptor> GetScriptDescriptors()
    {
        ScriptControlDescriptor des = new ScriptControlDescriptor("myControls.Glow", this.ClientID);
        des.AddProperty("text", _Text);
        des.AddProperty("backgroundColor", _BackgroundColor);
        List<ScriptDescriptor> colDes = new List<ScriptDescriptor>();
        colDes.Add( des );
        return colDes;
    }

    protected override void OnPreRender(EventArgs e)
    {
        ScriptManager.GetCurrent(Page).RegisterScriptControl(this);
        base.OnPreRender(e);
    }


    protected override void Render(HtmlTextWriter writer)
    {
        ScriptManager.GetCurrent(Page).RegisterScriptDescriptors(this);
        base.Render(writer);
    }

</script>

<div id='<%= this.ClientID %>'></div>