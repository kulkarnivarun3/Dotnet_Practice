<%@ Control Language="C#" ClassName="TabStrip" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    public event EventHandler TabClick;

    /// <summary>
    /// The index of the selected tab
    /// </summary>
    public int SelectedIndex
    {
        get { return dlstTabStrip.SelectedIndex; }
    }
    
    /// <summary>
    /// Create the tabs
    /// </summary>
    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            // Create the tabs
            List<string> tabs = new List<string>();
            tabs.Add("Products");
            tabs.Add("Services");
            tabs.Add("About");
            
            // Bind tabs to the DataList
            dlstTabStrip.DataSource = tabs;
            dlstTabStrip.DataBind();
            
            // Select first tab
            dlstTabStrip.SelectedIndex = 0;
        }
    }

    /// <summary>
    /// This method executes when a user clicks a tab
    /// </summary>
    protected void dlstTabStrip_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (TabClick != null)
            TabClick(this, EventArgs.Empty);
    }
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