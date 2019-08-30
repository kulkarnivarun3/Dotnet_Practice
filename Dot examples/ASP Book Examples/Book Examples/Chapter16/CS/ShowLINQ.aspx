<%@ Page Language="C#"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show LINQ</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdEmployees"
        DataSourceID="srcEmployees"
        runat="server" />
    
    <asp:ObjectDataSource
        id="srcEmployees"
        TypeName="Employee"
        SelectMethod="Select"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
