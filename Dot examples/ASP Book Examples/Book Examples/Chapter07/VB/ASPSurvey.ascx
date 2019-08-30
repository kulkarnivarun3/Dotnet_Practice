<%@ Control Language="VB" ClassName="ASPSurvey" %>
<script runat="server">
 
    Public ReadOnly Property KnowSlow() As Boolean
        Get
            Return chkSlow.Checked
        End Get
    End Property
 
    Public ReadOnly Property KnowOutdated() As Boolean
        Get
            Return chkOutdated.Checked
        End Get
    End Property
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