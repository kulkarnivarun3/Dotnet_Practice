<%@ Page Language="VB" Trace="true" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ImageRotator</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:ImageRotator
        id="ImageRotator1"
        Runat="server">
        <custom:ImageItem ImageUrl="Image1.gif" AlternateText="Image 1" />    
        <custom:ImageItem ImageUrl="Image2.gif" AlternateText="Image 2" />    
        <custom:ImageItem ImageUrl="Image3.gif" AlternateText="Image 3" />    
    </custom:ImageRotator>
        
    </div>
    </form>
</body>
</html>
