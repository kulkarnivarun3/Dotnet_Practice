<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
        {
            string dest = "~/Default.aspx";
            if (!String.IsNullOrEmpty(Request.QueryString["ReturnURL"]))
                dest = Request.QueryString["ReturnURL"];
            CreateUserWizard1.ContinueDestinationPageUrl = dest;
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>CreateUserWizard Return</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:CreateUserWizard
        id="CreateUserWizard1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
