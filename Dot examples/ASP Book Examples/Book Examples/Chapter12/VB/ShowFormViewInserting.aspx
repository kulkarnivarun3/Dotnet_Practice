<%@ Page Language="VB" %>
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
    <title>Show FormView Inserting</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
    
    <asp:FormView
        id="frmMovies"
        DataSourceID="srcMovies"
        AllowPaging="true"
        Runat="server">
        <ItemTemplate>
        <h1><%# Eval("Title") %></h1>
        <b>Directed By:</b> 
        <%# Eval("Director") %> 
        <br />
        <b>In Theaters:</b>         
        <%#Eval("InTheaters") %>
        <hr />
        <asp:LinkButton
            id="lnkNew"
            Text="New Movie"
            CommandName="New"
            Runat="server" />
        </ItemTemplate>
        <InsertItemTemplate>
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
        <asp:CheckBox
            id="chkInTheaters"
            Text="In Theaters"
            Checked='<%# Bind("InTheaters") %>'
            Runat="server" />
        <br /><br />
        <asp:LinkButton
            id="lnkInsert"
            Text="Insert Movie"
            CommandName="Insert"
            Runat="server" />  
        |      
        <asp:LinkButton
            id="lnkCancel"
            Text="Cancel Insert"
            CommandName="Cancel"
            Runat="server" />    
        </InsertItemTemplate>
    </asp:FormView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters 
            FROM Movies"
        InsertCommand="INSERT Movies (Title,Director,InTheaters)
            VALUES (@Title,@Director,@InTheaters)"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
