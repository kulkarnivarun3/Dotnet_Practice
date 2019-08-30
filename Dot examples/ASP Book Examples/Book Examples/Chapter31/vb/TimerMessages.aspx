<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Timer Messages</title>
    <style type="text/css">
    
    .message
    {
        margin-left: 20px;
        font-style:italic;
    }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
    <asp:ScriptManager ID="sm1" runat="server" />
    
    <asp:Timer ID="Timer1" Interval="5000" runat="server" />
    
    <asp:UpdatePanel ID="up1" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
    </Triggers>
    <ContentTemplate>
    Last Refresh <%= DateTime.Now.ToString("T") %>
    <hr />
    <asp:ListView
        id="lstMessages"
        DataSourceID="srcMessages"
        Runat="server">
        <LayoutTemplate>
            <div id="itemContainer" runat="server">
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <div>
                Posted by <%# Eval("PostedBy") %>
                <div class="message">
                <%# Eval("Post") %>
                </div>
            </div>    
        </ItemTemplate>
    </asp:ListView>    
    </ContentTemplate>      
    </asp:UpdatePanel>
    
    <asp:ObjectDataSource
        id="srcMessages"
        TypeName="Message"
        SelectMethod="Select"
        Runat="server" />
    
    </form>
</body>
</html>
