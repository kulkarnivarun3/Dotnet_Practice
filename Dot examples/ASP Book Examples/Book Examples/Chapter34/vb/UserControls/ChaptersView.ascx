<%@ Control Language="vb" ClassName="ChaptersView" %>

<script runat="server">

    Private _BookId As Integer
    Public Property BookId() As Integer
        Get
            Return _BookId
        End Get
        Set(ByVal value As Integer)
            _BookId = value
        End Set
    End Property

 
 
    Protected Sub srcChapters_Selecting(ByVal sender As Object, ByVal e As ObjectDataSourceSelectingEventArgs)
        e.InputParameters("BookId") = BookId
    End Sub


</script>




<asp:ListView
    id="lstChapters"
    DataSourceId="srcChapters"
    Runat="server">
   
    <LayoutTemplate>
        <div>
        <asp:PlaceHolder id="itemPlaceholder" runat="server" />
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
