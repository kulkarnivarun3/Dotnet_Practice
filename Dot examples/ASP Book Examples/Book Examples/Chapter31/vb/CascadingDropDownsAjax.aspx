<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cascading DropDownList Controls</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ScriptManager
        id="sm1"
        Runat="server" />

    <asp:UpdatePanel
        id="UpdatePanel1"
        Runat="server">
        <ContentTemplate>
        
    <asp:Label
        id="lblState"
        Text="State:"
        AssociatedControlID="ddlState"
        Runat="server" />
    <asp:DropDownList
        id="ddlState"
        DataSourceID="srcState"
        DataTextField="State"
        DataValueField="State"
        AutoPostBack="true"
        Runat="server" />
    <asp:SqlDataSource
        id="srcState"
        ConnectionString='<%$ ConnectionStrings:con %>'
        SelectCommand="SELECT State FROM State
            ORDER BY State"
        Runat="server" />
    
    <br /><br />

    
    <asp:Label
        id="Label1"
        Text="City:"
        AssociatedControlID="ddlCity"
        Runat="server" />
    <asp:DropDownList
        id="ddlCity"
        DataSourceID="srcCity"
        DataTextField="City"
        AutoPostBack="true"
        Runat="server" />
    <asp:SqlDataSource
        id="srcCity"
        ConnectionString='<%$ ConnectionStrings:con %>'
        SelectCommand="SELECT City FROM City
            WHERE State=@State
            ORDER BY City"
        Runat="server">
        <SelectParameters>
            <asp:ControlParameter Name="State" ControlID="ddlState" />
        </SelectParameters>
    </asp:SqlDataSource>    
    
    </ContentTemplate>
    </asp:UpdatePanel>    
    
    </div>
    </form>
</body>
</html>
