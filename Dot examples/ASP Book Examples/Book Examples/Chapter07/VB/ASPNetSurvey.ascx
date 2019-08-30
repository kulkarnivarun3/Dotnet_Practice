<%@ Control Language="VB" ClassName="ASPNetSurvey" %>
<script runat="server">
 
    Public ReadOnly Property KnowFast() As Boolean
        Get
            Return chkFast.Checked
        End Get
    End Property
 
    Public ReadOnly Property KnowNewest() As Boolean
        Get
            Return chkNewest.Checked
        End Get
    End Property
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