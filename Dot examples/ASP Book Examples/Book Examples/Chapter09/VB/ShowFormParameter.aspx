<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Private  Sub Page_Load()
        If Not Request.Form("AddMovie") Is Nothing Then
            srcMovies.Insert()
        End If
    End Sub
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show FormParameter</title>
</head>
<body>
    <form action="ShowFormParameter.aspx" method="post">

    <label for="txtTitle">Movie Title:</label>
    <br />
    <input name="txtTitle" />

    <br /><br />

    <label for="txtDirector">Movie Director:</label>
    <br />
    <input name="txtDirector" />

    <br /><br />
    <input name="AddMovie" type="submit" value="Add Movie" />

    </form>
    
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT * FROM Movies"
        InsertCommand="INSERT Movies (Title,Director,CategoryId,DateReleased)
            VALUES (@Title,@Director,0,'12/25/1966')"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server">
        <InsertParameters>
            <asp:FormParameter Name="Title" 
                FormField="txtTitle" DefaultValue="Untitled" />
            <asp:FormParameter Name="Director" 
                FormField="txtDirector" DefaultValue="Allen Smithee" />
        </InsertParameters>
    </asp:SqlDataSource>    
    
    </div>
    </form>
</body>
</html>
