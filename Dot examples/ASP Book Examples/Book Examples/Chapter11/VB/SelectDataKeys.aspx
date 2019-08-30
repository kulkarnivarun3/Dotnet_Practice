<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .content
        {
            width:600px;
            margin:auto;
            background-color:white;
        }
        .column
        {
            float:left;
            padding:10px;
            width:265px;
        }
        .column td,.column th
        {
            padding:5px;
            font:14px Georgia, Serif
        }
        .selectedRow
        {
            background-color:yellow;
        }
    </style>
    <title>Select Data Keys</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
    <div class="column">
    
    <asp:GridView
        id="grdEmployees"
        DataSourceID="srcEmployees"
        DataKeyNames="LastName,FirstName"
        AutoGenerateSelectButton="true"
        SelectedRowStyle-CssClass="selectedRow"
        Runat="server" />
        
    </div>
    <div class="column">
        
    <asp:DetailsView
        id="dtlEmployees"
        DataSourceID="srcEmployeeDetails"
        Runat="server" />
    
    </div>

    <br style="clear:both" />
    </div>
        
    <asp:SqlDataSource
        id="srcEmployees"
        ConnectionString="<%$ ConnectionStrings:Employees %>"
        SelectCommand="SELECT LastName,FirstName 
            FROM Employees"
        Runat="server" />    
        
    <asp:SqlDataSource
        id="srcEmployeeDetails"
        ConnectionString="<%$ ConnectionStrings:Employees %>"
        SelectCommand="SELECT * FROM Employees
            WHERE FirstName=@FirstName AND LastName=@LastName"
        Runat="server">
        <SelectParameters>
        <asp:ControlParameter
            Name="FirstName"
            ControlID="grdEmployees"
            PropertyName='SelectedDataKey("FirstName")' />   
        <asp:ControlParameter
            Name="LastName"
            ControlID="grdEmployees"
            PropertyName='SelectedDataKey("LastName")' />   
        </SelectParameters>
     </asp:SqlDataSource>   
    
    </form>
</body>
</html>
