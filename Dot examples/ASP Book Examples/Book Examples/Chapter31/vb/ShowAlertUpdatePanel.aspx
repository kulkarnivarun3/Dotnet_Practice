<%@ Page Language="vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected sub btnDeleteAll_Click(sender as object, e as EventArgs)
        If FileHelper.DeleteAll() = True Then
            Dim script As String = "alert('All Files Deleted Successfully!');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "filesDeleted", script, True)
        End If
    end sub
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
