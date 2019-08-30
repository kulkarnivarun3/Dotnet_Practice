<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="AspNetUnleashed" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <script type="text/javascript">
        
        function ItemInserted(error, controlID)
        {
            if (error == '')
            {
                var ajaxFormView = document.getElementById(controlID);
                var inputs = ajaxFormView.getElementsByTagName('input');
                for (var i=0;i < inputs.length;i++)
                    inputs[i].value = inputs[i].defaultValue;
                    
                window.setTimeout("AjaxDivView_Refresh()", 100);
            }
            else
                alert( 'Error: ' + error ); 
        }
    
    </script>
    
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        
        .headerStrip
        {
            margin-bottom:10px;
            padding:10px;
            background-color:white;
            border:solid 1px black;
        }
        
        .frmMovie
        {
            background-color:white;
            width:400px;
            padding:10px;
            margin-right:20px;
            float:left;
            border:solid 1px black;
        }
        
        .listMovies
        {
            background-color:white;
            float:left;
            padding:10px;
            border:solid 1px black;
        
        }
        
        .listMovies div
        {
            margin:10px;
            border:solid 1px black;
            padding:5px;
        }
    </style>
    
    <title>Show AjaxFormView</title>
</head>
<body>
    <form id="form1" runat="server">
    
    <div class="headerStrip">
    Page Time: <%= DateTime.Now.ToString("T") %>
    </div>
    
    <custom:AjaxFormView
        id="frmMovie"
        DataSourceID="srcMovies"
        DefaultMode="insert"
        OnClientItemInserted="ItemInserted"
        CssClass="frmMovie"
        Runat="server">
        <InsertItemTemplate>

        <asp:Label
            id="lblTitle"
            Text="Movie Title:"
            AssociatedControlID="txtTitle"
            Runat="server" />
        <br />
        <asp:TextBox
            id="txtTitle"
            Text='<%# Bind("Title") %>'
            Runat="server" />
        <br /><br />    
        <asp:Label
            id="Label1"
            Text="Movie Director:"
            AssociatedControlID="txtDirector"
            Runat="server" />        
        <br />
        <asp:TextBox
            id="txtDirector"
            Text='<%# Bind("Director") %>'
            Runat="server" />

        </InsertItemTemplate>
    </custom:AjaxFormView>    
    
    <custom:AjaxDivView
        id="listMovies"
        DataSourceID="srcMovies"
        CssClass="listMovies"
        Runat="server">
        <ItemTemplate>
        <h1><%# Eval("Title") %></h1>
        <em>Director:<%# Eval("Director") %></em>
        </ItemTemplate>
    </custom:AjaxDivView>           
        
        
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title, Director 
            FROM Movies ORDER BY Id DESC"
        InsertCommand="INSERT MOVIES (Title, Director)
            VALUES (@Title, @Director)"
        Runat="server" />
 
        
    
    </div>
    </form>
</body>
</html>
