<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected sub btnSubmit_Click(sender as object, e as EventArgs)
        System.Threading.Thread.Sleep(5000)
    end sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Show UpdateProgress</title>
    <style type="text/css">
    .progress
    {
        font-family:Arial;
        position: absolute;
        background-color:lightyellow;
        border:solid 2px red;
        padding:5px;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <%= DateTime.Now.ToString("T") %>
            <asp:Button
                id="btnSubmit"
                Text="Submit"
                Runat="server" OnClick="btnSubmit_Click" />
        </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress 
            ID="progress1" 
            AssociatedUpdatePanelID="up1" 
            runat="server">
            <ProgressTemplate>
                <div class="progress">
                <asp:Image
                    id="imgProgress"
                    ImageUrl="~/Images/Progress.gif"
                    Runat="server" />
                    Retrieving content...
                </div>    
            </ProgressTemplate>
        </asp:UpdateProgress>
    
    </div>
    </form>
</body>
</html>
