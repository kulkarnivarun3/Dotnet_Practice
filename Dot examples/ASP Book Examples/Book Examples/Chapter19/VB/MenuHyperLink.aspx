<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Menu HyperLink</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Menu
        id="Menu1"
        Runat="server">
        <Items>
            <asp:MenuItem 
                Text="Products"
                NavigateUrl="Products.aspx" />
            <asp:MenuItem
                Text="Services"
                NavigateUrl="Services.aspx">
                <asp:MenuItem
                    Text="Training"
                    NavigateUrl="Training.aspx" />
                <asp:MenuItem
                    Text="Consulting"
                    NavigateUrl="Consulting.aspx" />    
            </asp:MenuItem>        
        </Items>
    </asp:Menu>    
    
    </div>
    </form>
</body>
</html>
