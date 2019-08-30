<%@ Page Language="VB" %>
<%@ OutputCache Duration="3600" VaryByParam="none" VaryByCustom="css" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        If Request.Browser.SupportsCss Then
            pnlCss.Visible = True
        Else
            pnlNotCss.Visible = True
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Vary By Custom</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:Panel
        id="pnlCss"
        Visible="false"
        Runat="server">
        <span style="font-weight:bold">Hello!</span>    
    </asp:Panel>

    <asp:Panel
        id="pnlNotCss"
        Visible="false"
        Runat="server">
        <b>Hello!</b>    
    </asp:Panel>
    
    </div>
    </form>
</body>
</html>
