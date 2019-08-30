<%@ Page Language="VB" trace="true"%>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Data.Linq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    sub page_Load()
        Dim db As New MyDatabaseDataContext()
        db.Log = New TraceWriter()
        grd.DataSource = db.Movies.Where(Function(m) m.Id = 2)
        grd.DataBind()
    end sub


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:GridView
        id="grd"
        Runat="server" />

    
    </div>
    </form>
</body>
</html>
