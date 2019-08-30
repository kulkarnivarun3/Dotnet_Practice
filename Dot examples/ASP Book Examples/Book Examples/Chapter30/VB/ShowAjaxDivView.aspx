<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="AspNetUnleashed" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <script type="text/javascript">
        
    window.onload = function() 
    {
        window.setInterval("AjaxDivView_Refresh()", 5000);
    }
    </script>

    <style type="text/css">
        h1
        {
            font-size:16px;
        }
        .ajaxDivView div
        {
            border:solid 1px black;
            padding:5px;
            margin:10px;
        }
    
    </style>
    <title>Show AjaxDivView</title>
</head>
<body language="javascript">
    <form id="form1" runat="server">
    <div>
    
    Page Time: <%= DateTime.Now.ToString() %>  
    
    <br /><br />
    <button onclick="AjaxDivView_Refresh();return false;">Refresh</button>
    
    <br /><br />
    <custom:AjaxDivView
        id="AjaxDivView1"
        DataSourceID="srcMovies"
        CssClass="ajaxDivView"
        Runat="server">
        <ItemTemplate>
        
        <h1><%# Eval("Title") %></h1>
        <em>Director: <%# Eval("Director") %></em>
        
        </ItemTemplate>
    </custom:AjaxDivView>    
    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director FROM Movies"
        Runat="server" />    
    
    </div>
    </form>
</body>
</html>
