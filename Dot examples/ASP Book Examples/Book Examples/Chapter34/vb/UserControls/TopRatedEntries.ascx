﻿<%@ Control Language="vb" ClassName="TopRatedEntries" %>
<%@ Register TagPrefix="user" TagName="EntryView" Src="~/UserControls/EntryView.ascx" %>

<script runat="server">

</script>

<h1>Top Rated Code Samples</h1>

<asp:ListView
    id="lstEntries"
    DataSourceID="srcEntries"
    Runat="server">
    <LayoutTemplate>
        <div>
        <asp:PlaceHolder id="itemPlaceholder" runat="server" />
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
    SelectMethod="SelectByRating"
    Runat="server" />

