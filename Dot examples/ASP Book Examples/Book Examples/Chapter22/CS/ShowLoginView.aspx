<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show LoginView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:LoginStatus
        id="LoginStatus"
        Runat="server" />
    <hr />
    
    <asp:LoginView
        id="LoginView1"
        Runat="server">
        <AnonymousTemplate>
        This content is displayed to anonymous users.            
        </AnonymousTemplate>
        <LoggedInTemplate>
        This content is displayed to authenticated users.
        </LoggedInTemplate>    
    </asp:LoginView>
    
    </div>
    </form>
</body>
</html>
