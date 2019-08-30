<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show TemplateField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateColumns="false"
        AutoGenerateEditButton="true"
        Runat="server">
        <Columns>
        <asp:TemplateField HeaderText="Title">
            <ItemTemplate>
            <%# Eval("Title") %>
            </ItemTemplate>
            <EditItemTemplate>
            <asp:TextBox
                id="txtTitle"
                Text='<%# Bind("Title") %>'
                Runat="server" />
            <asp:RequiredFieldValidator
                id="valTitle"
                ControlToValidate="txtTitle"
                Text="(required)"
                Runat="server" />    
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Category">
            <ItemTemplate>
            <%# Eval("Name") %>
            </ItemTemplate>
            <EditItemTemplate>
            <asp:DropDownList
                id="ddlCategory"
                DataSourceID="srcMovieCategories"
                DataTextField="Name"
                DataValueField="Id"
                SelectedValue='<%# Bind("CategoryId") %>'
                Runat="server" />
            </EditItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString='<%$ ConnectionStrings:Movies %>'
        SelectCommand="SELECT Movies.Id, Title, CategoryId, Name
            FROM Movies JOIN MovieCategories
            ON MovieCategories.Id = Movies.CategoryId"
        UpdateCommand="UPDATE Movies SET Title=@Title, CategoryId=@CategoryId
            WHERE Id=@Id"    
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovieCategories"
        ConnectionString='<%$ ConnectionStrings:Movies %>'
        SelectCommand="SELECT Id, Name FROM MovieCategories"        
        Runat="server" />
        
    </div>
    </form>
</body>
</html>
