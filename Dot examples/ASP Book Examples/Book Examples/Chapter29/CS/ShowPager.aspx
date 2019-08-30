<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Pager</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="GridView1"
        DataSourceID="srcMovies"
        AllowPaging="true"
        PageSize="3"
        PagerSettings-Visible="false"
        Runat="server" />
    
    <custom:Pager
        id="Pager1"
        ControlToPage="GridView1"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="Data Source=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|MyDatabase.mdf;User Instance=True"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
