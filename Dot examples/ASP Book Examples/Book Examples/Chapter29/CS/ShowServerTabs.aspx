<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .tab
        {
            float:left;
            position:relative;
            top:1px;
            background-color:#eeeeee;
            border:solid 1px black;
            padding:0px 15px;
            margin-left:5px;
        }
        .tab a
        {
            text-decoration:none;
        }
        .selectedTab
        {
            background-color:white;
            border-bottom:solid 1px white;
        }
        .tabContents
        {
            border:solid 1px black;
            background-color:white;
            padding:10px;
            height:200px;
        }
    </style>
    <title>Show ServerTabs</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:ServerTabs
        ID="ServerTabs1"
        Runat="Server">
        <tab Text="First Tab">
          Contents of the first tab
        </tab>    
        <tab Text="Second Tab">
          Contents of the second tab
        </tab>    
        <tab Text="Third Tab">
          Contents of the third tab
        </tab>    
    </custom:ServerTabs>
    
    </div>
    </form>
</body>
</html>
