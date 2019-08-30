<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        div
        {
            padding:10px;
        }
        .labelStyle
        {
            color:red;
            background-color:yellow;
            border:Solid 2px Red;
        }
    </style>
    <title>Format Label</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblFirst"
        Text="First Label"
        ForeColor="Red"
        BackColor="Yellow"
        BorderStyle="Solid"
        BorderWidth="2"
        BorderColor="red"
        Runat="server" />
    
    <br /><br />
    
    <asp:Label
        id="lblSecond"
        Text="Second Label"
        CssClass="labelStyle"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
