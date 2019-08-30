<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        Application("AppStart") = DateTime.Now
    End Sub
</script>
