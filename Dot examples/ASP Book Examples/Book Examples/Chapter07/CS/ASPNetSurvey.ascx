<%@ Control Language="C#" ClassName="ASPNetSurvey" %>
<script runat="server">

    public bool KnowFast
    {
        get { return chkFast.Checked; }
    }
        
    public bool KnowNewest
    {
        get { return chkNewest.Checked; }   
    }    
    
</script>
<asp:CheckBox
    id="chkFast"
    Text="Did you know that ASP.NET is fast?"
    Runat="server" />
    
<br /><br />

<asp:CheckBox
    id="chkNewest"
    Text="Did you know that ASP.NET is the newest Microsoft
        technology for building Web applications?"
    Runat="server" />
<br /><br />