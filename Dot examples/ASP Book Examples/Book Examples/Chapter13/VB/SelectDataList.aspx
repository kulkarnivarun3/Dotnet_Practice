<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:orange;
    }
    .content
    {
        margin:auto;
        width:600px;
        background-color:white;
    }
    .column
    {
        float:left;
        width:250px;
        padding:20px;
    }
    .movies td
    {
        padding:10px;
    }
    a
    {
        padding:10px;
        color:red;
    }
    a:hover
    {
        background-color:Gold;
    }
    </style>
    <title>Select DataList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
    
    <div class="column">
    <asp:DataList
        id="dlstMovieCategories"
        DataSourceID="srcMovieCategories"
        DataKeyField="Id"
        GridLines="Both"
        CssClass="movies"
        Runat="server">
        <ItemTemplate>
        <asp:LinkButton
            id="lnkMovie"
            Text='<%#Eval("Name") %>'
            CommandName="Select"
            Runat="server" />
        </ItemTemplate>
    </asp:DataList>    
    </div>
    
    <div class="column">
    <asp:DataList
        id="dlstMovieDetails"
        DataSourceID="srcMovieDetails"
        Runat="server">
        <ItemTemplate>
        <h1><%#Eval("Title")%></h1>
        Directed by: 
        <%#Eval("Director") %>
        <br />
        Box Office Totals:
        <%#Eval("BoxOfficeTotals","{0:c}") %>
        </ItemTemplate>
    </asp:DataList>
    </div>
    <br style="clear:both" />
    </div>
    
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id, Name FROM MovieCategories"
        Runat="server" />

    <asp:SqlDataSource
        id="srcMovieDetails"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Title,Director,BoxOfficeTotals 
            FROM Movies WHERE CategoryId=@CategoryId"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter 
            Name="CategoryId" 
            ControlID="dlstMovieCategories" 
            PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
