<%@ Page Language="C#" %>
<%@ Register TagPrefix="user" TagName="TabStrip" Src="~/TabStrip.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void TabStrip1_TabClick(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = TabStrip1.SelectedIndex;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
            font:14px Georgia,Serif;
        }
        .tabs a
        {
            color:blue;
            text-decoration:none;
            font:14px Arial,Sans-Serif;            
        }
        .tab
        {
            background-color:#eeeeee;
            padding:5px;
            border:Solid 1px black;
            border-bottom:none;
        }
        .selectedTab
        {
            background-color:white;
            padding:5px;
            border:Solid 1px black;
            border-bottom:none;
        }
        .views
        {
            background-color:white;
            width:400px;
            border:Solid 1px black;
            padding:10px;
        }
    </style>
    <title>Show TabStrip</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <user:TabStrip
        ID="TabStrip1"
        OnTabClick="TabStrip1_TabClick" 
        Runat="Server" />
        
    <div class="views">
    <asp:MultiView
        id="MultiView1"
        ActiveViewIndex="0"
        Runat="server">
        <asp:View ID="Products" runat="server">
            <h1>Products</h1>
            We sell a variety of useful products...
        </asp:View>
        <asp:View ID="Services" runat="server">
            <h1>Services</h1>
            We offer a number of services...
        </asp:View>
        <asp:View ID="About" runat="server">
            <h1>About</h1>
            We were the first company to offer products and services...
        </asp:View>
    </asp:MultiView>
    </div>
        
    </div>
    </form>
</body>
</html>
