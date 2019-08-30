<%@ Control Language="C#" ClassName="SlidingUserCache" %>
<%@ OutputCache Duration="10" VaryByParam="none" %>
<script runat="server">

    void Page_Load()
    {
        CachePolicy.SetSlidingExpiration(true);
        CachePolicy.Duration = TimeSpan.FromMinutes(1);
    }
    
</script>

User Control Time:
<%= DateTime.Now.ToString("T") %>
