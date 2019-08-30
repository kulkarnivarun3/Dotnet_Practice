<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Code Samples By Tag" %>
<%@ Register TagPrefix="user" TagName="EntryView" Src="~/UserControls/EntryView.ascx" %>
<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


<asp:ListView
    id="lstEntries"
    DataSourceID="srcEntries"
    Runat="server">
    <LayoutTemplate>
        <div>
        <asp:PlaceHolder 
            id="itemPlaceholder" 
            runat="server" />
        </div>
    </LayoutTemplate>
    <ItemTemplate>

    <user:EntryView
        id="EntryView1"
        Runat="server" />

    </ItemTemplate>
    
</asp:ListView>


<asp:ObjectDataSource
    id="srcEntries"
    TypeName="Entry"
    SelectMethod="SelectByTag"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="tag" QueryStringField="tag" />
    </SelectParameters>
</asp:ObjectDataSource>    



</asp:Content>

