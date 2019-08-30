<%@ Control Language="VB" ClassName="SlidingUserCache" %>
<%@ OutputCache Duration="10" VaryByParam="none" %>
<script runat="server">

    Sub Page_Load()
        CachePolicy.SetSlidingExpiration(true)
        CachePolicy.Duration = TimeSpan.FromMinutes(1)
    End Sub
</script>

User Control Time:
<%= DateTime.Now.ToString("T") %>
