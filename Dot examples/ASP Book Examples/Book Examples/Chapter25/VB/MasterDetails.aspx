<%@ Page Language="VB" %>
<%@ OutputCache Duration="3600" VaryByControl="dropCategories" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Master/Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <%= DateTime.Now.ToString("T") %>
    <hr />
    
    <asp:DropDownList
        id="dropCategories"
        DataSourceID="srcCategories"
        DataTextField="Name"
        DataValueField="Id"
        Runat="server" />
    <asp:Button
        id="btnSelect"
        Text="Select"
        Runat="server" />
    
    <br /><br />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        GridLines="none"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Name FROM MovieCategories"
        Runat="server" />

    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director FROM Movies
            WHERE CategoryId=@CategoryId"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter 
            Name="CategoryId"
            ControlID="dropCategories" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
