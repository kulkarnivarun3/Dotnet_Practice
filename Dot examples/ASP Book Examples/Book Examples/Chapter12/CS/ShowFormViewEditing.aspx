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
    a
    {
        color:blue;
    }
    </style>
    <title>Show FormView Editing</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
    
    <asp:FormView
        id="frmMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AllowPaging="true"
        Runat="server">
        <ItemTemplate>
        <h1><%# Eval("Title") %></h1>
        <b>Directed By:</b> 
        <%# Eval("Director") %> 
        <br />
        <b>Box Office Totals:</b>         
        <%#Eval("BoxOfficeTotals", "{0:c}") %>
        <hr />
        <asp:LinkButton
            id="lnkEdit"
            Text="Edit Movie"
            CommandName="Edit"
            Runat="server" />
        </ItemTemplate>
        <EditItemTemplate>
        <asp:Label
            id="lblTitle"
            Text="Movie Title:"
            AssociatedControlID="txtTitle"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtTitle"
            Text='<%# Bind("Title") %>'
            Runat="server" />
        <br /><br />    
        <asp:Label
            id="lblDirector"
            Text="Movie Director:"
            AssociatedControlID="txtDirector"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtDirector"
            Text='<%# Bind("Director") %>'
            Runat="server" />
        <br /><br />    
        <asp:Label
            id="lblBoxOfficeTotals"
            Text="Box Office Totals:"
            AssociatedControlID="txtBoxOfficeTotals"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtBoxOfficeTotals"
            Text='<%# Bind("BoxOfficeTotals") %>'
            Runat="server" />
        <br /><br />
        <asp:LinkButton
            id="lnkUpdate"
            Text="Update Movie"
            CommandName="Update"
            Runat="server" />  
        |      
        <asp:LinkButton
            id="lnkCancel"
            Text="Cancel Update"
            CommandName="Cancel"
            Runat="server" />    
        </EditItemTemplate>
    </asp:FormView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,BoxOfficeTotals 
            FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            Director=@Director,BoxOfficeTotals=@BoxOfficeTotals
            WHERE Id=@Id"    
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
