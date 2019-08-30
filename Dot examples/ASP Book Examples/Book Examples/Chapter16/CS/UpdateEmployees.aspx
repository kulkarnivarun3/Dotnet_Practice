<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Update Employees</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:DetailsView ID="DetailsView1"
        DataSourceID="srcEmployees"
        DataKeyNames="Id"
        AutoGenerateRows="True"
        AutoGenerateEditButton="True"
        AllowPaging="true"
        Runat="server" />

    <asp:ObjectDataSource
        id="srcEmployees"
        TypeName="EmployeeData"
        DataObjectTypeName="CompanyEmployee"
        SelectMethod="GetEmployees"
        UpdateMethod="UpdateEmployee"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
