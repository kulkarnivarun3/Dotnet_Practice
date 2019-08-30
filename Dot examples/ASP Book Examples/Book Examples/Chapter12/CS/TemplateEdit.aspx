<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Template Edit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovies"
        AutoGenerateRows="false"
        AutoGenerateEditButton="true"
        AllowPaging="true"
        DefaultMode="Edit"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        Runat="server">
        <Fields>
        <asp:TemplateField HeaderText="Title:">
        <EditItemTemplate>
        <asp:TextBox
            id="txtTitle"
            Text='<%# Bind("Title") %>'
            runat="server" />
        <asp:RequiredFieldValidator
            id="reqTitle"
            ControlToValidate="txtTitle"
            Text="(required)"
            Display="Dynamic"
            Runat="server" />    
        </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Box Office Totals:">
        <EditItemTemplate>
        <asp:TextBox
            id="txtBoxOfficeTotals"
            Text='<%# Bind("BoxOfficeTotals", "{0:f}") %>'
            runat="server" />
        <asp:RequiredFieldValidator
            id="reqBoxOfficeTotals"
            ControlToValidate="txtBoxOfficeTotals"
            Text="(required)"
            Display="Dynamic"
            Runat="server" />    
        <asp:CompareValidator
            id="cmpBoxOfficeTotals"
            ControlToValidate="txtBoxOfficeTotals"
            Text="(invalid)"
            Display="Dynamic"
            Operator="DataTypeCheck"
            Type="currency"
            Runat="server" />
        </EditItemTemplate>
        </asp:TemplateField>
        </Fields>
    </asp:DetailsView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,BoxOfficeTotals FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            BoxOfficeTotals=@BoxOfficeTotals WHERE Id=@Id"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
