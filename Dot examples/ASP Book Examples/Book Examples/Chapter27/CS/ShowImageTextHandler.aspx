<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ImageTextHandler</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <img src="ImageTextHandler.ashx?text=Some Text&font=WebDings&size=42" />
    <br />
    <img src="ImageTextHandler.ashx?text=Some Text&font=Comic Sans MS&size=42" />
    <br />
    <img src="ImageTextHandler.ashx?text=Some Text&font=Courier New&size=42" />
    
    </div>
    </form>
</body>
</html>
