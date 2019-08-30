<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    /// <summary>
    /// When the details link is clicked, display the popup window
    /// </summary>
    protected void grdEmployees_SelectedIndexChanged(object sender, EventArgs e)
    {
        divEdit.Style["display"] = "block";
    }

    /// <summary>
    /// When the Details/Edit close link is clicked, close
    /// the popup window
    /// </summary>
    protected void lnkClose_Click(object sender, EventArgs e)
    {
        divEdit.Style["display"] = "none";
    }

    /// <summary>
    /// When an employee is edited, refresh the contents of 
    /// the GridView
    /// </summary>
    protected void frmEdit_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        grdEmployees.DataBind();
    }

    /// <summary>
    /// Add a confirmation dialog box to the Delete links
    /// </summary>
    protected void grdEmployees_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnkDelete = (LinkButton)e.Row.Cells[0].Controls[0];
            lnkDelete.Attributes["onclick"] = "return confirm('Delete Record?')";   
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
    html
    {
        background-color:silver;
        font-family:Georgia,Serif;
    }
    #content
    {
        position:relative;
        width:700px;
        height:400px;
        margin:0px auto;
        border:solid 1px black;
        background-color:white;
        padding:10px;
    }
    .popupWindow
    {
        position:absolute;
        left:100px;
        top:50px;
        width:400px;
        border:solid 1px black;
        padding:10px;
        background-color:white;
        filter:progid:DXImageTransform.Microsoft.dropshadow(OffX=5, OffY=5, Color=#cccccc); 
        display:none;
    }
    .list td
    {
        border-bottom:solid 1px black;
        padding:10px;
    }
    </style>
    <title>Employee Directory</title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">

    <%-- List Employees --%>
    <asp:GridView
        id="grdEmployees"
        DataSourceId="srcEmployees"
        DataKeyNames="Id"
        AllowPaging="true"
        AutoGenerateColumns="false"
        GridLines="none"
        CssClass="list"
        OnSelectedIndexChanged="grdEmployees_SelectedIndexChanged"
        Runat="server" OnRowCreated="grdEmployees_RowCreated">
        <Columns>
        <asp:CommandField ShowSelectButton="true" 
            SelectText="Details" ShowDeleteButton="true"  />
        <asp:BoundField DataField="LastName" HeaderText="Last Name" />
        <asp:BoundField DataField="FirstName" HeaderText="First Name" />
        </Columns>
    </asp:GridView>    
    <br />
    <button onclick="document.getElementById('divAdd').style.display='block';return false;">Add Employee</button>    
            

    <%-- Edit Employee --%> 
    <div id="divEdit" class="popupWindow" Runat="server">
    <asp:FormView
        id="frmEdit"
        DataKeyNames="Id"
        DataSourceId="srcEditEmployee"
        CssClass="employeeForm"
        Runat="server" OnItemUpdated="frmEdit_ItemUpdated">
        <ItemTemplate>
        <h3>Employee Details</h3>
        <b>Name:</b>
        <%# Eval("FirstName") %> <%# Eval("LastName") %>
        <br /><br />
        <b>Phone:</b> <%# Eval("Phone") %>
        <br /><br />
        <b>Email:</b> <%# Eval("Email") %>
        <br /><br />
        <asp:LinkButton
            id="lnkClose"
            Text="Close"
            OnClick="lnkClose_Click" 
            Runat="server"/>
        &nbsp;|&nbsp;
        <asp:LinkButton
            id="lnkEdit"
            Text="Edit"
            CommandName="Edit"
            Runat="server" />
        </ItemTemplate>
        <EditItemTemplate>
        <h3>Edit Employee</h3>
        <asp:Label
            id="lblFirstName"
            Text="First Name:"
            AssociatedControlID="txtFirstName"
            Runat="server" />
        <asp:TextBox
            id="txtFirstName"
            Text='<%# Bind("FirstName") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valFirstName"
            ControlToValidate="txtFirstName"         
            Text="(Required)"
            ValidationGroup="frmEdit"
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblLastName"
            Text="Last Name:"
            AssociatedControlID="txtLastName"
            Runat="server" />
        <asp:TextBox
            id="txtLastName"
            Text='<%# Bind("LastName") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valLastName"
            ControlToValidate="txtLastName"         
            Text="(Required)"
            ValidationGroup="frmEdit"
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblPhone"
            Text="Phone Number:"
            AssociatedControlID="txtPhone"
            Runat="server" />
        <asp:TextBox
            id="txtPhone"
            Text='<%# Bind("Phone") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valPhone"
            ControlToValidate="txtPhone"         
            Text="(Required)"
            ValidationGroup="frmEdit"
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblEmail"
            Text="Email Address:"
            AssociatedControlID="txtEmail"
            Runat="server" />
        <asp:TextBox
            id="txtEmail"
            Text='<%# Bind("Email") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valEmail"
            ControlToValidate="txtEmail"         
            Text="(Required)"
            Display="Dynamic"
            ValidationGroup="frmEdit"
            Runat="server" />
       <br /><br />
       <asp:LinkButton
            id="lnkUpdate"
            Text="Update"
            CommandName="Update"
            Runat="server" />
       &nbsp;|&nbsp;     
       <asp:LinkButton
            id="lnkCancel"
            Text="Cancel"
            CommandName="Cancel"
            CausesValidation="false"
            Runat="server" />
       </EditItemTemplate>
    </asp:FormView>    
    </div>

    <%-- Add Employee --%>
    <div id="divAdd" class="popupWindow">
    <h3>Add Employee</h3>
    <asp:FormView
        id="frmAdd"
        DataSourceId="srcEmployees"
        DefaultMode="Insert"
        Runat="server">
        <InsertItemTemplate>
        <asp:Label
            id="lblFirstName"
            Text="First Name:"
            AssociatedControlID="txtFirstName"
            Runat="server" />
        <asp:TextBox
            id="txtFirstName"
            Text='<%# Bind("FirstName") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valFirstName"
            ControlToValidate="txtFirstName"         
            Text="(Required)"
            ValidationGroup="frmAdd"
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblLastName"
            Text="Last Name:"
            AssociatedControlID="txtLastName"
            Runat="server" />
        <asp:TextBox
            id="txtLastName"
            Text='<%# Bind("LastName") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valLastName"
            ControlToValidate="txtLastName"         
            Text="(Required)"
            ValidationGroup="frmAdd"
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblPhone"
            Text="Phone Number:"
            AssociatedControlID="txtPhone"
            Runat="server" />
        <asp:TextBox
            id="txtPhone"
            Text='<%# Bind("Phone") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valPhone"
            ControlToValidate="txtPhone"         
            Text="(Required)"
            ValidationGroup="frmAdd"
            Runat="server" />
        <br /><br />
        <asp:Label
            id="lblEmail"
            Text="Email Address:"
            AssociatedControlID="txtEmail"
            Runat="server" />
        <asp:TextBox
            id="txtEmail"
            Text='<%# Bind("Email") %>'
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valEmail"
            ControlToValidate="txtEmail"         
            Text="(Required)"
            ValidationGroup="frmAdd"
            Runat="server" />
       <br /><br />
       <asp:LinkButton
            id="lnkInsert"
            Text="Add"
            CommandName="Insert"
            ValidationGroup="frmAdd"
            Runat="server" />
       &nbsp;|&nbsp;     
       <asp:LinkButton
            id="lnkCancel"
            Text="Cancel"
            CommandName="Cancel"
            CausesValidation="false"
            Runat="server" />
       </InsertItemTemplate> 
    </asp:FormView>    
    </div>

    <%-- Data Sources --%>
    <asp:SqlDataSource
        id="srcEmployees"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|EmployeeDB.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT * FROM Employees"
        InsertCommand="INSERT Employees (LastName,FirstName,Phone,Email)
            VALUES (@LastName,@FirstName,@Phone,@Email)"
        DeleteCommand="DELETE Employees WHERE Id=@Id"
        Runat="server" />
        
    <asp:SqlDataSource
        id="srcEditEmployee"
        ConnectionString="Data Source=.\SQLExpress;
            AttachDbFilename=|DataDirectory|EmployeeDB.mdf;
            Integrated Security=True;User Instance=True"
        SelectCommand="SELECT * FROM Employees WHERE Id=@Id"
        UpdateCommand="UPDATE Employees SET LastName=@LastName,
            FirstName=@FirstName,Phone=@Phone,Email=@Email
            WHERE Id=@id"
        Runat="server">
        <SelectParameters>
            <asp:ControlParameter Name="Id" ControlID="grdEmployees" />
        </SelectParameters>
    </asp:SqlDataSource>    
    
    </div>
    </form>
</body>
</html>
