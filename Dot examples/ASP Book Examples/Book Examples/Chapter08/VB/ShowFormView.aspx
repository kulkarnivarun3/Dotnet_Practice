<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show FormView</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:FormView
        id="FormView1"
        DataKeyNames="Id"
        DataSourceId="srcMovies"
        DefaultMode="Edit"
        AllowPaging="true"
        Runat="server">
        <EditItemTemplate>
        <asp:Label
            id="lblTitle"
            Text="Title:"
            AssociatedControlID="txtTitle"
            Runat="server" />
        <asp:TextBox
            id="txtTitle"
            Text='<%#Bind("Title")%>'
            Runat="server" />
        <br />     
        <asp:Label
            id="lblDirector"
            Text="Director:"
            AssociatedControlID="txtDirector"
            Runat="server" />
        <asp:TextBox
            id="txtDirector"
            Text='<%#Bind("Director")%>'
            Runat="server" />
        <br />     
        <asp:Button
            id="btnUpdate"
            Text="Update"
            CommandName="Update"
            Runat="server" />        
        </EditItemTemplate>
    </asp:FormView>    

    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT Id, Title,Director,DateReleased FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            Director=@Director WHERE Id=@Id"
        Runat="server" />

    
    </div>
    </form>
</body>
</html>
