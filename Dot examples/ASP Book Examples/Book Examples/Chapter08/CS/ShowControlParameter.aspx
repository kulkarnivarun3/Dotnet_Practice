<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Control Parameter</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:DropDownList
        id="ddlMovieCategory"
        DataSourceID="srcMovieCategories"
        DataTextField="Name"
        DataValueField="Id"
        Runat="server" />
        
    <asp:Button
        id="btnSelect"
        Text="Select"
        ToolTip="Select Movie"
        Runat="server" />    
        
    <hr />
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString="Server=.\SQLExpress;
        Trusted_Connection=True;AttachDbFileName=|DataDirectory|MyDatabase.mdf;
        User Instance=True"
        SelectCommand="SELECT Id,Name FROM MovieCategories"
        Runat="server" />

    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|MyDatabase.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT Title,Director FROM Movies 
            WHERE CategoryId=@Id"
        Runat="server">
        <SelectParameters>
            <asp:ControlParameter 
                Name="Id"
                Type="int32"
                ControlID="ddlMovieCategory" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
