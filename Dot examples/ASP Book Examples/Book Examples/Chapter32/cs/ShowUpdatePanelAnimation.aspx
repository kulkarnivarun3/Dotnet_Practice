<%@ Page Language="C#" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(2000);
        lblSelectedColor.Text = txtFavoriteColor.Text;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show UpdatePanel Animation</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <%-- First Update Panel --%>

        <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
        
        <asp:Label
            id="lblFavoriteColor"
            Text="Enter Your Favorite Color:"
            Runat="server" />
        <asp:TextBox
            id="txtFavoriteColor"
            Runat="server" />    
        <asp:Button
            id="btnSubmit"
            Text="Submit"
            Runat="server" OnClick="btnSubmit_Click" />
            
        </ContentTemplate>
        </asp:UpdatePanel>
        <ajax:UpdatePanelAnimationExtender
            id="upae1"
            TargetControlID="up1"
            runat="server">
        <Animations>
            <OnUpdating>
            <Color
                Duration="0.5"
                Fps="20"
                Property="style"
                PropertyKey="backgroundColor"
                StartValue="#FFFFFF"
                EndValue="#FFFF90" />

            </OnUpdating>
            <OnUpdated>
            <Color
                Duration="1"
                Fps="20"
                Property="style"
                PropertyKey="backgroundColor"
                StartValue="#FFFF90"
                EndValue="#FFFFFF" />
            </OnUpdated>
        </Animations>    
        </ajax:UpdatePanelAnimationExtender>        

        <p>&nbsp;</p>

        <%-- Second Update Panel --%>
        <asp:UpdatePanel ID="up2" runat="server">
        <ContentTemplate>
        
        You selected: 
        <asp:Label
            id="lblSelectedColor"
            Runat="server" />
           
        </ContentTemplate>
        </asp:UpdatePanel>
        <ajax:UpdatePanelAnimationExtender
            id="UpdatePanelAnimationExtender1"
            TargetControlID="up2"
            runat="server">
        <Animations>
            <OnUpdating>
            <Color
                Duration="0.5"
                Fps="20"
                Property="style"
                PropertyKey="backgroundColor"
                StartValue="#FFFFFF"
                EndValue="#FFFF90" />

            </OnUpdating>
            <OnUpdated>
            <Color
                Duration="3"
                Fps="20"
                Property="style"
                PropertyKey="backgroundColor"
                StartValue="#FFFF90"
                EndValue="#FFFFFF" />
            </OnUpdated>
        </Animations>    
        </ajax:UpdatePanelAnimationExtender>        



    </div>
    </form>
</body>
</html>
