<%@ Application Language="VB" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<script runat="server">
 
    Public Overrides Function GetVaryByCustomString(ByVal context As HttpContext, ByVal custom As String) As String
        If String.Compare(custom, "css") = 0 Then
            Return Request.Browser.SupportsCss.ToString()
        End If
        Return MyBase.GetVaryByCustomString(context, custom)
    End Function
 
    Private Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Enable Push SQL cache dependencies
        'Dim conString As String = WebConfigurationManager.ConnectionStrings("MyMovies").ConnectionString
        'SqlDependency.Start(conString)
 
        Dim context As HttpContext = HttpContext.Current
        context.Cache.Insert( _
            "MovieKey", _
            DateTime.Now, _
            Nothing, _
            DateTime.MaxValue, _
            Cache.NoSlidingExpiration, _
            CacheItemPriority.NotRemovable, _
            Nothing)
    End Sub
</script>
