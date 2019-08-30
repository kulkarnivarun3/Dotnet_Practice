<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Protected Sub dtlMovie_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim movieTitle As String = DataBinder.Eval(dtlMovie.DataItem, "Title")
    
        If sm1.IsInAsyncPostBack Then
            sm1.RegisterDataItem(Head1, movieTitle)
        Else
            Head1.Title = movieTitle
            hTitle.InnerHtml = movieTitle
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>UpdatePanel DataItem</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager
        id="sm1"
        Runat="server" />
    
    <h1 id="hTitle" runat="server"></h1>
    
    
    <asp:UpdatePanel    
        id="upSearch"
        Runat="server">
        <ContentTemplate>
        
        <asp:DetailsView
            id="dtlMovie"
            DataSourceID="srcMovies"
            AllowPaging="true"
            Runat="server" OnDataBound="dtlMovie_DataBound" />
                
        </ContentTemplate>    
    </asp:UpdatePanel>
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString='<%$ ConnectionStrings:con %>'
        SelectCommand="SELECT Id,Title,Director FROM Movie"
        Runat="server" />
    
    </div>
    </form>
    <script type="text/javascript">
    
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_pageLoaded( prm_pageLoaded );
    
    function prm_pageLoaded(sender, args)
    {
        if (prm.get_isInAsyncPostBack())
        {
            var movieTitle = args.get_dataItems()['Head1'];
            // assign browser title bar
            document.title = movieTitle;
            // assign heading
            $get('hTitle').innerHTML = movieTitle;
        }
    }
    </script>
</body>
</html>
