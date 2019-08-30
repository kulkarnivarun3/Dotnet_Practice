<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        Article1.Title = "Creating Templated Databound Controls"
        Article1.Author = "Stephen Walther"
        Article1.Contents = "Blah, blah, blah, blah..."
        Article1.DataBind()
    End Sub
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Article</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <custom:Article
        id="Article1"
        Runat="server">
        <ItemTemplate>
        
        <h1><%# Container.Title %></h1>
        <em>By <%# Container.Author %></em>
        <br /><br />
        <%# Container.Contents %>
        
        </ItemTemplate>
    </custom:Article>    
    
    </div>
    </form>
</body>
</html>
