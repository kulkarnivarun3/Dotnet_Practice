<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

<asp:FormView
    id="frmEntry"
    DataSourceId="srcEntry"
    Runat="server">
    <ItemTemplate>
    
    <div class="divEntry">
    
    <h1><%# Eval("Title") %></h1>
    <div class="divEntryPostedBy">
        Posted by <%# Eval("AuthorUserName") %> on <%# Eval("DateCreated", "D") %>
    </div>
    
    <div class="divEntryDescription">
    <%# Eval("Description") %>    
    </div>
    
    
    <asp:ListView
        id="lstCodeSamples"
        DataSourceId="srcCodeSamples"
        Runat="server">
        <LayoutTemplate>
            <div>
            <asp:PlaceHolder 
                id="itemPlaceholder" 
                runat="server" />
            </div>
        </LayoutTemplate>
        <ItemTemplate>
        <h2><%# Eval("FileName") %></h2>
        <div class="divCodeSampleDescription">
            <%# Eval("Description") %>
        </div>
        <div class="divCodeSampleCode">
            <%# HttpUtility.HtmlEncode((string)Eval("Code")) %>
        </div>
        
        
        
        </ItemTemplate>    
    </asp:ListView>
    
    <asp:ObjectDataSource
        id="srcCodeSamples"
        TypeName="CodeSample"
        SelectMethod="SelectByEntryId"
        Runat="server">
        <SelectParameters>
            <asp:QueryStringParameter Name="entryId" QueryStringField="entryId" />
        </SelectParameters>
    </asp:ObjectDataSource>    
    
    
    </div>    
    
    </ItemTemplate>    
</asp:FormView>


<asp:ObjectDataSource
    id="srcEntry"
    TypeName="Entry"
    SelectMethod="Get"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="id" QueryStringField="entryId" />
    </SelectParameters>
</asp:ObjectDataSource>    




</asp:Content>

