<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void dtlMovie_DataBound(object sender, EventArgs e)
    {
        string movieTitle = (string)DataBinder.Eval(dtlMovie.DataItem, "Title");
    
        if (sm1.IsInAsyncPostBack)
        {
            sm1.RegisterDataItem(Head1, movieTitle);
        }
        else
        {
            Head1.Title = movieTitle;
            hTitle.InnerHtml = movieTitle;
        }
    }
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
