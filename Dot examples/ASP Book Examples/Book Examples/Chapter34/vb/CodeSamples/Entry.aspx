<%@ Page Language="vb" MasterPageFile="~/Design/MasterPage.master" Title="Untitled Page" %>
<%@ Register TagPrefix="user" TagName="CodeView" Src="~/UserControls/CodeView.ascx" %>
<%@ Register TagPrefix="user" TagName="EntryTagView" Src="~/UserControls/EntryTagView.ascx" %>

<script runat="server">

     
 
    ''' <summary>
    ''' Called by the Rating control through an Ajax call
    ''' </summary>
    Protected Sub Rating1_Changed(ByVal sender As Object, ByVal e As RatingEventArgs)
        EntryRating.Insert(New EntryRating() With {.EntryId = Int32.Parse(e.Tag), .Rating = Int32.Parse(e.Value)})
    End Sub
        
    Protected Sub srcEntry_Deleted(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If e.Exception Is Nothing Then
            Response.Redirect("~/CodeSamples/Default.aspx")
        End If
    End Sub
 
    Protected Sub frmEnTry_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Me.Title = CType(DataBinder.Eval(frmEntry.DataItem, "Title"), String)
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


<asp:FormView
    id="frmEntry"
    DataSourceID="srcEntry"
    DataKeyNames="Id,Version"
    Runat="server" OnDataBound="frmEntry_DataBound">
    <ItemTemplate>
    
    <h1>
        <asp:Literal
            id="ltlTitle"
            Text='<%# Eval("Title") %>'
            Mode="Encode"
            Runat="server" />
    </h1>
        
    <div style="width:700px">
        <%# Eval("Description") %>
    </div>
    
    <div class="metaInfo">
        Posted by: <user:UserView ID="UserView1" runat="server" />    
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
        
        <h2>
        <asp:Literal
            id="ltlTitle"
            Text='<%# Eval("FileName") %>'
            Mode="Encode"
            Runat="server" />
        (<%# Eval("CodeSampleLanguage.Name") %>)    
        </h2>
        
        <div>
            <%# Eval("Description") %>
        </div>
        
        <user:CodeView
            id="CodeView1"
            Runat="Server" />
        
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

    <div class="metaInfo">
        <user:EntryTagView
            id="EntryTagView1"
            EntryId='<%# Eval("Id") %>'
            Runat="server" />
    </div>
    
    <div class="rating">
        Rate this Code Sample:
        <ajaxToolkit:Rating 
            ID="Rating1" 
            BehaviorID="RatingBehavior1"
            CurrentRating="2"
            MaxRating="5"
            StarCssClass="ratingStar"
            WaitingStarCssClass="savedRatingStar"
            FilledStarCssClass="filledRatingStar"
            EmptyStarCssClass="emptyRatingStar"
            runat="server" 
            style="float:left"
            Tag='<%# Eval("Id") %>'
            OnChanged="Rating1_Changed" />
    </div>

    <div class="clearBoth"></div>
    
    <div class="viewed">
        This Code Sample has been viewed: <%# Eval("ViewCount") %> times
    </div>
    
    <asp:HyperLink
        id="lnkEdit"
        Text="{Edit}"
        NavigateUrl='<%# Eval("Id", "~/Authenticated/Entries/Edit.aspx?entryId={0}")%>'
        Visible='<%# User.IsInRole("Administrators") %>'
        Runat="server" />

    <asp:LinkButton
        id="lnkDelete"
        Text="{Delete}"
        CommandName="Delete"
        OnClientClick="return confirm('Delete this entry and all related code samples?')"
        Visible='<%# User.IsInRole("Administrators") %>'
        Runat="server" />
    
    </ItemTemplate>
</asp:FormView>





<super:EntityDataSource
    id="srcEntry"
    TypeName="Entry"
    SelectMethod="GetFull"
    Runat="server" OnDeleted="srcEntry_Deleted">
    <SelectParameters>
        <asp:QueryStringParameter Name="Id" QueryStringField="entryId" />
    </SelectParameters>
</super:EntityDataSource>






</asp:Content>

