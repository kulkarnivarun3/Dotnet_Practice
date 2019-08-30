<%@ Application Language="VB" %>
<%@ Import Namespace="System.IO" %>
<script runat="server">
 
    Private Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        AddHandler SiteMap.SiteMapResolve, AddressOf SiteMap_SiteMapResolve
    End Sub
 
    Private Function SiteMap_SiteMapResolve(ByVal sender As Object, ByVal e As SiteMapResolveEventArgs) As SiteMapNode
        If SiteMap.CurrentNode Is Nothing Then
            Dim url As String = e.Context.Request.Path
            Dim title As String = Path.GetFileNameWithoutExtension(url)
            Dim NewNode As New SiteMapNode(e.Provider, url, url, title)
            NewNode.ParentNode = SiteMap.RootNode
            Return NewNode
        End If
        Return SiteMap.CurrentNode
    End Function
</script>
