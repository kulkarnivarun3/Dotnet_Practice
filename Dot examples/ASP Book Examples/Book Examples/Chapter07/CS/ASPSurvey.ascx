<%@ Control Language="C#" ClassName="ASPSurvey" %>
<script runat="server">

    public bool KnowSlow
    {
        get { return chkSlow.Checked; }
    }
        
    public bool KnowOutdated
    {
        get { return chkOutdated.Checked; }   
    }    
    
</script>

<asp:CheckBox
    id="chkSlow"
    Text="Did you know that ASP Classic is slow?"
    Runat="server" />
    
<br /><br />

<asp:CheckBox
    id="chkOutdated"
    Text="Did you know that ASP Classic is outdated?"
    Runat="server" />
<br /><br />    