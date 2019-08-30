<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>
<%@ Register TagPrefix="user" TagName="TopRatedEntries" Src="~/UserControls/TopRatedEntries.ascx" %>
<%@ Register TagPrefix="user" TagName="TopViewedEntries" Src="~/UserControls/TopViewedEntries.ascx" %>
<%@ Register TagPrefix="user" TagName="MostRecentEntries" Src="~/UserControls/MostRecentEntries.ascx" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">

    <div class="column">

        <user:TopRatedEntries
            id="TopRatedEntries1"
            Runat="server" />


        <user:MostRecentEntries
            id="MostRecentEntries1"
            Runat="server" />

    </div>


    <div class="column">

        <user:TopViewedEntries
            id="TopViewedEntries"
            Runat="server" />

    </div>

    <div class="clearBoth"></div>

    <asp:HyperLink
        id="lnkAdd"
        Text="Add New Code Sample"
        NavigateUrl="~/Authenticated/Entries/Edit.aspx"
        Runat="server" />

</asp:Content>
