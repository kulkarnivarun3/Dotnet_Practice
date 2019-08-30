<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            foreach (ListItem item in cblSelectRoles.Items)
                if (!Roles.RoleExists(item.Text))
                {
                    Roles.CreateRole(item.Text);
                    Roles.AddUserToRole(User.Identity.Name, item.Text);
                } 
        }
    }
    
    protected void btnSelect_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in cblSelectRoles.Items)
        {
            if (item.Selected)
            {
                if (!User.IsInRole(item.Text))
                    Roles.AddUserToRole(User.Identity.Name, item.Text);
            }
            else
            {
                if (User.IsInRole(item.Text))
                    Roles.RemoveUserFromRole(User.Identity.Name, item.Text);
            }
        }
        Response.Redirect(Request.Path);
    }
    
    void Page_PreRender()
    {
        foreach (ListItem item in cblSelectRoles.Items)
            item.Selected = User.IsInRole(item.Text);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .column
        {
            float:left;
            width:300px;
            border:Solid 1px black;
            background-color:white;
            padding:10px;
        }
    </style>
    <title>Show Security Trimming</title>
</head>
<body>
    <form id="form1" runat="server">
    
    <div class="column">
    
    <asp:Label
        id="lblSelectRoles"
        Text="Select Roles:"
        AssociatedControlID="cblSelectRoles"
        Runat="server" />
    
    <br />
    
    <asp:CheckBoxList
        id="cblSelectRoles"
        Runat="server">
        <asp:ListItem Text="RoleA" />
        <asp:ListItem Text="RoleB" />
        <asp:ListItem Text="RoleC" />
    </asp:CheckBoxList>    
        
    <asp:Button
        id="btnSelect"
        Text="Select"
        OnClick="btnSelect_Click" 
        Runat="server" />    
    
    </div>
    
    <div class="column">
    
    <asp:TreeView
        id="TreeView1"
        DataSourceID="srcSiteMap"
        Runat="server" />
    
    <asp:SiteMapDataSource
        id="srcSiteMap"
        Runat="server" />
    
    </div>
    
    
    </form>
</body>
</html>
