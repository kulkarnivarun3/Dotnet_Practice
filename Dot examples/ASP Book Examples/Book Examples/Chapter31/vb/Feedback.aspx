<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Feedback</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager
        id="sm1"
        Runat="server" />
    
    
    <asp:UpdatePanel
        id="up1"
        Runat="server">
        <ContentTemplate>
   
    <asp:FormView
        id="frmFeedback"
        DataSourceId="srcFeedback"
        DefaultMode="Insert"
        Runat="server">
        <InsertItemTemplate>
        
        <asp:Label
            id="lblName"
            Text="Name:"
            AssociatedControlID="txtName"
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valName"
            Text="Required"
            ControlToValidate="txtName"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtName"
            Text='<%# Bind("Name") %>'
            Runat="server" />
        <br /><br />    
        <asp:Label
            id="lblComment"
            Text="Comment:"
            AssociatedControlID="txtComment"
            Runat="server" />
        <asp:RequiredFieldValidator
            id="valComment"
            Text="Required"
            ControlToValidate="txtComment"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtComment"
            Text='<%# Bind("Comment") %>'
            TextMode="MultiLine"
            Columns="50"
            Rows="3"
            Runat="server" />
        <br /><br />
        <asp:Button
            id="btnSubmit"
            Text="Submit"
            CommandName="Insert"
            Runat="server" />    
        </InsertItemTemplate>
    </asp:FormView>
    
    <br /><br />
    
    <asp:GridView
        id="grdFeedback"
        DataSourceID="srcFeedback"
        AllowSorting="true"
        Runat="server" />
    
    </ContentTemplate>
    </asp:UpdatePanel>
    
    
    <asp:SqlDataSource
        id="srcFeedback"
        ConnectionString='<%$ ConnectionStrings:con %>'
        SelectCommand="SELECT Id,Name,Comment,DateSubmitted
            FROM Feedback"
        InsertCommand="INSERT Feedback (Name,Comment)
            VALUES (@Name,@Comment)"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
