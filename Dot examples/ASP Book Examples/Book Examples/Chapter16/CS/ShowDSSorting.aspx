<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    .employees td,.employees th
    {
        font:16px Georgia,Serif;
        padding:5px;
    }
    a
    {
        color:blue;
    }
    </style>
    <title>Show Data Source Sorting</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdEmployees"
        DataSourceID="srcEmployees"
        AllowSorting="true"
        AllowPaging="true"
        PageSize="3"
        CssClass="employees"
        Runat="server" />
        
    <asp:ObjectDataSource
        id="srcEmployees"
        TypeName="EmployeesDSSorting"
        SelectMethod="GetEmployees"
        SelectCountMethod="GetEmployeeCount"
        EnablePaging="true"
        SortParameterName="sortExpression"
        Runat="server" />    
    
    
    </div>
    </form>
</body>
</html>
