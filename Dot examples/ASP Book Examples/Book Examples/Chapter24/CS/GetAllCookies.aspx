<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {

        ArrayList colCookies = new ArrayList();
        for (int i = 0; i < Request.Cookies.Count; i++)
            colCookies.Add(Request.Cookies[i]);

        grdCookies.DataSource = colCookies;
        grdCookies.DataBind();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Get All Cookies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdCookies"
        Runat="server"/>
        
    </div>
    </form>
</body>
</html>
