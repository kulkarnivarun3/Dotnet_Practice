<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        for (int i = 0; i < 100; i++)
            bltList.Items.Add("Item " + i.ToString());
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .contents
        {
            background-color:white;
            width:200px;
            height:200px;
        }
    </style>
    <title>Panel ScrollBars</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Panel
        id="pnlContent"
        ScrollBars="Auto"
        CssClass="contents"
        Runat="server">
        <asp:BulletedList
            id="bltList"
            Runat="server" />
    </asp:Panel>    
    
    </div>
    </form>
</body>
</html>
