<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Append List Items</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DropDownList
        id="ddlMovies"
        DataSourceID="srcMovies"
        DataTextField="Title"
        DataValueField="Id"
        AppendDataBoundItems="True"
        Runat="server">
        <asp:ListItem 
            Text="Select a Movie"
            Value="" />
    </asp:DropDownList>    
    
    <asp:RequiredFieldValidator
        id="valMovies"
        Text="(Required)"
        ControlToValidate="ddlMovies"
        Runat="server" />

    <br /><br />
        
    <asp:Button
        id="btnSubmit"
        Text="Submit Form"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Id, Title FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
