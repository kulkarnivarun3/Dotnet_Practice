<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:silver;
    }
    #content
    {
        margins:auto;
        width:600px;
        padding:10px;
        background-color:white;
        font:14px Georgia,Serif;
    }
    .frmMovies
    {
        width:100%;
    }
    </style>
    <title>Show FormView Pager Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
    
    <asp:FormView
        id="frmMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        CssClass="frmMovies"
        Runat="server">
        <ItemTemplate>
        <h1><%# Eval("Title") %></h1>
        <b>Directed By:</b> 
        <%# Eval("Director") %>
        <br />
        <b>Box Office Totals:</b> 
        <%#Eval("BoxOfficeTotals", "{0:c}") %>
        </ItemTemplate>
        <PagerTemplate>
        <hr />
        <div style="float:left">
        Page: <%# frmMovies.PageIndex + 1 %>
        </div>
        
        <div style="float:right;white-space:nowrap">
        <asp:LinkButton
            id="lnkPrevious"
            Text="Previous Page"
            CommandName="Page"
            CommandArgument="Prev"
            Runat="server" />
        |
        <asp:LinkButton
            id="lnkNext"
            Text="Next Page"
            CommandName="Page"
            CommandArgument="Next"
            Runat="server" />
        </div>
        </PagerTemplate>
    </asp:FormView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,BoxOfficeTotals FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
