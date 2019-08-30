<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Trigger Update Panel</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ScriptManager
        id="sm1"
        Runat="server" />
        
    Page Time: <%= DateTime.Now.ToString("T") %>    
    <br />
    <asp:Button
        id="btnUpdate"
        Text="Update"
        Runat="server" />
            
    <asp:UpdatePanel
        id="up1"
        Runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger 
                ControlID="btnUpdate" 
                EventName="Click" />
        </Triggers>
        <ContentTemplate>
        
        Update Panel Time: <%= DateTime.Now.ToString("T") %>
        
        </ContentTemplate>
    </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
