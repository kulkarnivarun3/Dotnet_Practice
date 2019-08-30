<%@ Page Language="C#" Async="true" AsyncTimeout="1" Trace="true" %>
<%@ Import Namespace="System.Threading" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    private AsyncDataLayer dataLayer = new AsyncDataLayer();
    
    void Page_Load()
    {
        // Setup asynchronous data execution
        PageAsyncTask task = new PageAsyncTask(BeginGetData, EndGetData, TimeoutData, null, true);
        Page.RegisterAsyncTask(task);

        // Fire off asynchronous tasks
        Page.ExecuteRegisteredAsyncTasks();           
    }

    IAsyncResult BeginGetData(object sender, EventArgs e, AsyncCallback callback, object state)
    {
        // Show Page Thread ID
        Trace.Warn("BeginGetData: " + Thread.CurrentThread.GetHashCode());

        // Execute asynchronous command
        return dataLayer.BeginGetMovies(callback, state);
    }

    void EndGetData(IAsyncResult ar)
    {
        // Show Page Thread ID
        Trace.Warn("EndGetDate: " + Thread.CurrentThread.GetHashCode());

        // Bind results
        grdMovies.DataSource = dataLayer.EndGetMovies(ar);
        grdMovies.DataBind();
    }

    void TimeoutData(IAsyncResult ar)
    {
        // Display error message        
        lblError.Text = "Could not retrieve data!";
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Page AsyncTask</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblError"
        Runat="server" />
    
    <asp:GridView
        id="grdMovies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
