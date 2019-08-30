<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .siteMapPath
        {
            font:20px Comic Sans MS,Serif;
        }
        .currentNodeStyle
        {
            font-weight:bold;
        } 
        .nodeStyle
        {
            text-decoration:none;
        }
        .pathSeparatorStyle
        {
            background-color:yellow;
            margin:10px;
            border:Solid 1px black;
        }
        .rootNodeStyle
        {
            text-decoration:none;
        }
    </style>
    <title>SiteMapPath Style</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:SiteMapPath
        id="SiteMapPath1"
        CssClass="siteMapPath"
        CurrentNodeStyle-CssClass="currentNodeStyle"
        NodeStyle-CssClass="nodeStyle"
        PathSeparatorStyle-CssClass="pathSeparatorStyle"
        RootNodeStyle-CssClass="rootNodeStyle"
        Runat="server" />
    
    <hr />

    <h1>SiteMapPath Style</h1>
    
    </div>
    </form>
</body>
</html>
