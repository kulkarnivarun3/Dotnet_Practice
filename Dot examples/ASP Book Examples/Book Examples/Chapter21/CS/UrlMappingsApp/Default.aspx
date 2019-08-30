<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    void Page_Load()
    {
        if (String.Compare(Request.Path, Request.RawUrl, true) != 0)
            lblMessage.Text = "The URL to this page has changed, " +
                "please update your bookmarks.";
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <style type="text/css">
        html
        {
            font:14px Georgia,Serif;
        }
        .message
        {
            border:Dotted 2px red;
            background-color:yellow;
        }
    </style>
    <title>Default Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h1>The Default Page</h1>
    
    <p>
    <asp:Label
        id="lblMessage"
        CssClass="message"
        Runat="server" />
    </p>
    
    The original request was for:
    <blockquote>
        <%=Request.RawUrl%>
    </blockquote>
    which got remapped to:
    <blockquote>
        <%= Request.Path %>
    </blockquote>
    and the application relative version is:
    <blockquote>
        <%= Request.AppRelativeCurrentExecutionFilePath %>
    </blockquote>    
    
    </div>
    </form>
</body>
</html>
