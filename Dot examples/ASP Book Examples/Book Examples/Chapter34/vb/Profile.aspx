<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

<asp:FormView
    id="frmProfile"
    DataSourceID="srcProfile"
    Runat="server">
    <ItemTemplate>
    
    <h1>
    <asp:Literal
        id="ltlUserName"
        Text='<%# String.Format("{0} ({1} {2})", Eval("UserName"), Eval("FirstName"), Eval("LastName") ) %>'
        Mode="Encode"
        Runat="server" />
    </h1>
    
    Website Url: 
    <asp:HyperLink
        id="lnkWebsite"
        Text='<%# Eval("WebsiteUrl") %>'
        NavigateUrl='<%# Eval("WebsiteUrl") %>'
        Target="_blank"
        Runat="server" />
    
    
    <div>
    
    <%# Eval("Profile") %>
    
    </div>
    
    
    </ItemTemplate>
</asp:FormView>


<asp:ObjectDataSource
    id="srcProfile"
    TypeName="WebUser"
    SelectMethod="Get"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="userName" QueryStringField="userName" />
    </SelectParameters>
</asp:ObjectDataSource>    


</asp:Content>

