<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show DetailsView Explicit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:DetailsView
        id="dtlMovie"
        DataKeyNames="Id"
        DataSourceID="srcMovies"
        AutoGenerateEditButton="true"
        DefaultMode="Edit"
        AllowPaging="true"
        runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="Select * FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,Director=@Director,
            DateReleased=@DateReleased WHERE Id=@id"
        Runat="server">
        <UpdateParameters>
          <asp:Parameter Name="Title" 
            Type="String" Size="100" DefaultValue="Untitled" />
          <asp:Parameter Name="Director" 
            Type="String" Size="100" DefaultValue="Alan Smithee" />
          <asp:Parameter Name="DateReleased" Type="DateTime" />
          <asp:Parameter Name="id" Type="int32" />  
        </UpdateParameters>
    </asp:SqlDataSource>    
    </div>
    </form>
</body>
</html>
