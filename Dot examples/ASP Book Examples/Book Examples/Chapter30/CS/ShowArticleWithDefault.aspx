<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        ArticleWithDefault1.Title = "Creating Templated Databound Controls";
        ArticleWithDefault1.Author = "Stephen Walther";
        ArticleWithDefault1.Contents = "Blah, blah, blah, blah...";
        ArticleWithDefault1.DataBind();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Article with Default Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:ArticleWithDefault
        id="ArticleWithDefault1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
