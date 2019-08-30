<%@ Page Language="C#" %>
<%@ Register TagPrefix="user" TagName="RandomQuotation" Src="~/RandomQuotation.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .quote
        {
            width:200px;
            padding:20px;
            border:Dotted 2px orange;
            background-color:#eeeeee;
            font:16px Georgia,Serif;
        }
    </style>
    <title>Show Random Quotation</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <%= DateTime.Now %>
    <br />
    
    <user:RandomQuotation
        id="RandomQuotation1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
