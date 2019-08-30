<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>

<script runat="server">


    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static string[] GetSuggestions(string prefixText, int count)
    {
        return Entry.GetSuggestions(prefixText, count);
    }



    protected void btnFilter_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(txtEntryTitle.Text))
        {
            grdMatch.DataSource = Entry.SelectByTitle(txtEntryTitle.Text);
            grdMatch.DataBind();
        } 
    }

    protected void grdMatch_SelectedIndexChanged(object sender, EventArgs e)
    {
        int entryId = (int)grdMatch.SelectedValue;
        int chapterId = Int32.Parse(Request["chapterId"]);
        Listing.Insert( new Listing() { EntryId = entryId, ChapterId = chapterId , OrderNumber=0});
        Response.Redirect("~/Books/Listings.aspx?chapterId=" + chapterId.ToString());
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


 <h3>Add Listing</h3>


    <asp:Label
        id="lblEntryTitle"
        Text="Filter by Entry Title"
        AssociatedControlID="txtEntryTitle"
        Runat="server" /> 
    <asp:TextBox
        id="txtEntryTitle"
        AutoComplete="Off"
        Text='<%# Bind("Name") %>'
        Runat="server" />
    <ajaxToolkit:AutoCompleteExtender 
        ID="AutoCompleteExtender1"
        ServiceMethod="GetSuggestions"
        TargetControlID="txtEntryTitle"
        MinimumPrefixLength="1"
        Runat="server" />
    <asp:Button
        id="btnFilter"
        Text="Filter"
        Runat="server" OnClick="btnFilter_Click" />



    <br />
    
    <asp:GridView
        id="grdMatch"
        DataKeyNames="Id"
        AutoGenerateSelectButton="true"
        AutoGenerateColumns="false"
        Runat="server" OnSelectedIndexChanged="grdMatch_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" />
        </Columns>    
        <EmptyDataTemplate>
        No matching code samples
        </EmptyDataTemplate>
    </asp:GridView>    
 
 



</asp:Content>

