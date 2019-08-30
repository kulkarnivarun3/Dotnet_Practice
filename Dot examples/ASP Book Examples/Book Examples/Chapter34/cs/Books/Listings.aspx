<%@ Page Language="C#" MasterPageFile="~/Design/MasterPage.master" Title="Chapter Listings" %>

<script runat="server">


    void Page_Load()
    {
        if (!IsPostBack)
        {
            if (User.IsInRole("Administrators"))
            {
                lnkAdd.Visible = true;
                lnkAdd.NavigateUrl = "~/Admin/Listings/Edit.aspx?chapterId=" + Request["chapterId"];
            }
            else
            {
                lnkAdd.Visible = false;
            }
        
        }
    
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" Runat="Server">


<asp:FormView
    id="frmChapter"
    DataSourceId="srcChapter"
    runat="server">
    <ItemTemplate>
    <h1><%# Eval("Title") %></h1>    
    
    <%# Eval("Description") %>
    
    </ItemTemplate>
</asp:FormView>


<asp:ObjectDataSource
    id="srcChapter"
    TypeName="Chapter"
    SelectMethod="Get"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="Id" QueryStringField="chapterId" />
    </SelectParameters>
</asp:ObjectDataSource>    



<asp:ListView
    id="lstListings"
    DataSourceId="srcListings"
    DataKeyNames="Id"
    Runat="server">
   
    <LayoutTemplate>
        <div>
        <asp:PlaceHolder 
            id="itemPlaceholder" 
            runat="server" />
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div class="listingRow">
        
            <h3>
                <asp:HyperLink
                    id="lnkEntry"
                    Text='<%# Eval("Title") %>'
                    NavigateUrl='<%# Eval("Id", "~/CodeSamples/Entry.aspx?entryId={0}") %>'
                    Runat="server" />
            </h3>
            
            <p>
                <asp:Literal
                    id="ltlIntroductionText"
                    Text='<%# Eval("IntroductionText") %>'
                    Mode="Encode"
                    Runat="server" />
            </p>
            
            <asp:LinkButton
                id="lnkDelete"
                CommandName="Delete"
                Text="{Delete}"
                OnClientClick="return confirm('Are you sure that you want to remove this code sample?')"
                Visible='<%# User.IsInRole("Administrators") %>'
                Runat="server" />
        
        </div>
        
    </ItemTemplate>
</asp:ListView>


<asp:HyperLink
    id="lnkAdd"
    Text="{Add Listing}"
    Runat="server" />




<super:EntityDataSource
    id="srcListings"
    TypeName="Listing"
    SelectMethod="SelectByChapterId"
    Runat="server">
    <SelectParameters>
        <asp:QueryStringParameter Name="chapterId" QueryStringField="chapterId" />
    </SelectParameters>    
</super:EntityDataSource>    



</asp:Content>

