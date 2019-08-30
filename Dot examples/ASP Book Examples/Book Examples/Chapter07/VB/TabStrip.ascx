<%@ Control Language="VB" ClassName="TabStrip" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
 
    Public Event TabClick As EventHandler
 
    ''' <summary>
    ''' The index of the selected tab
    ''' </summary>
    Public ReadOnly Property SelectedIndex() As Integer
        Get
            Return dlstTabStrip.SelectedIndex
        End Get
    End Property
 
    ''' <summary>
    ''' Create the tabs
    ''' </summary>
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            ' Create the tabs
            Dim tabs As New List(Of String)()
            tabs.Add("Products")
            tabs.Add("Services")
            tabs.Add("About")
 
            ' Bind tabs to the DataList
            dlstTabStrip.DataSource = tabs
            dlstTabStrip.DataBind()
 
            ' Select first tab
            dlstTabStrip.SelectedIndex = 0
        End If
    End Sub
 
    ''' <summary>
    ''' This method executes when a user clicks a tab
    ''' </summary>
    Protected Sub dlstTabStrip_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        RaiseEvent TabClick(Me, EventArgs.Empty)
    End Sub

</script>

<asp:DataList   
    id="dlstTabStrip"
    RepeatDirection="Horizontal"
    OnSelectedIndexChanged="dlstTabStrip_SelectedIndexChanged"
    CssClass="tabs"
    ItemStyle-CssClass="tab"
    SelectedItemStyle-CssClass="selectedTab"
    Runat="server">
    <ItemTemplate>
    <asp:LinkButton
        id="lnkTab"
        Text='<%# Container.DataItem %>'
        CommandName="Select"
        Runat="server" />
    </ItemTemplate>
</asp:DataList>    