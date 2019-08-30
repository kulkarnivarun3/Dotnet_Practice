<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Sub Page_Load()
        If Not Page.IsPostBack Then
            For Each item As ListItem In cblSelectRoles.Items
                If Not Roles.RoleExists(item.Text) Then
                    Roles.CreateRole(item.Text)
                    Roles.AddUserToRole(User.Identity.Name, item.Text)
                End If
            Next
        End If
    End Sub
 
    Sub btnSelect_Click(ByVal sender As Object, ByVal e As EventArgs)
        For Each item As ListItem In cblSelectRoles.Items
            If item.Selected Then
                If Not User.IsInRole(item.Text) Then
                    Roles.AddUserToRole(User.Identity.Name, item.Text)
                End If
            Else
                If User.IsInRole(item.Text) Then
                    Roles.RemoveUserFromRole(User.Identity.Name, item.Text)
                End If
            End If
        Next
        Response.Redirect(Request.Path)
    End Sub
 
    Sub Page_PreRender()
        For Each item As ListItem In cblSelectRoles.Items
            item.Selected = User.IsInRole(item.Text)
        Next
    End Sub

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
