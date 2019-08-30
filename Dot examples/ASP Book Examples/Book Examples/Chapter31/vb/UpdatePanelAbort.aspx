<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected sub btnGetFortune_Click(sender as object, e as EventArgs)
        System.Threading.Thread.Sleep(3000) ' wait 3 seconds
        lblFortune.Text = String.Format("At {0:T}, the oracle says: ", DateTime.Now)
        Dim rnd As New Random()
        select case (rnd.Next(4))
            Case 0
                lblFortune.Text &= "You're doomed!"
            Case 1
                lblFortune.Text += "Good luck is around the corner."
            Case 2
                lblFortune.Text += "Don't leave home."
            Case 3
                lblFortune.Text += "Buy stock today."
        End Select
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>UpdatePanel Abort</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
        <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <asp:Button
                id="btnGetFortune"
                Text="Get Fortune"
                OnClick="btnGetFortune_Click" 
                Runat="server" />
            <asp:Button
                id="btnCancel"
                Text="Cancel"
                Enabled="false"
                Runat="server" />
                <br />
                <asp:Label ID="lblFortune" runat="server" />
        </ContentTemplate>
        </asp:UpdatePanel>
            
    </div>
    </form>
    <script type="text/javascript">

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_initializeRequest(prm_initializeRequest);
    
    function prm_initializeRequest(sender, args)
    {
        if (args.get_postBackElement().id == 'btnCancel')
        {
            prm.abortPostBack();
            alert("Fortune Aborted!");
        }
        else
        {
            $get('btnCancel').disabled = false;
        }
    }
    </script>
</body>
</html>
