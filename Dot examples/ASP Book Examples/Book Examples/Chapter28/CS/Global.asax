<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        Application["AppStart"] = DateTime.Now;

    }
</script>
