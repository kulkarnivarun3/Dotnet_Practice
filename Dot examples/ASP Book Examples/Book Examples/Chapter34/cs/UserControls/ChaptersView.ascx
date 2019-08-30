<%@ Control Language="C#" ClassName="ChaptersView" %>

<script runat="server">

    public int BookId { get; set; }


    protected void srcChapters_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["BookId"] = BookId;
    }
</script>




<asp:ListView
    id="lstChapters"
    DataSourceId="srcChapters"
    Runat="server">
   
    <LayoutTemplate>
        <div>
        <asp:PlaceHolder 
            id="itemPlaceholder" 
            runat="server" />
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div>
        <h4><%# Eval("Title") %></h4>
        
        <%# Eval("Description") %>
        
        <asp:HyperLink
            id="lnkListings"
            Text="View Listings"
            NavigateUrl='<%# Eval("Id", "~/Books/Listings.aspx?chapterId={0}" ) %>'
            Runat="server" />
        
        </div>
        
    </ItemTemplate>
</asp:ListView>



<super:EntityDataSource
    id="srcChapters"
    TypeName="Chapter"
    SelectMethod="SelectByBookId"
    OnSelecting="srcChapters_Selecting" 
    Runat="server" />
