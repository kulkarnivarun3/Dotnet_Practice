<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {
        if (FileHelper.DeleteAll() == true)
        {
            string script = @"alert('All Files Deleted Successfully!');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "filesDeleted", script, true);
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show Alert UpdatePanel</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ScriptManager
        id="sm1"
        Runat="server" />

    <asp:UpdatePanel id="up1" runat="server">
    <ContentTemplate>
    UpdatePanel Time: <%= DateTime.Now.ToString("T") %>
    <br />
    <asp:Button
        id="btnDeleteAll"
        Text="Delete All Files"
        OnClick="btnDeleteAll_Click" 
        Runat="server" />

    </ContentTemplate>
    </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
