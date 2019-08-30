<%@ Page Language="VB" Async="true" AsyncTimeout="5" Trace="true" %>
<%@ Import Namespace="System.Threading" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Private dataLayer As New AsyncDataLayer()
 
    Private Sub Page_Load()
        ' Setup asynchronous data execution
        Dim task As PageAsyncTask = New PageAsyncTask(AddressOf BeginGetData, AddressOf EndGetData, AddressOf TimeoutData, Nothing, True)
        Page.RegisterAsyncTask(task)
 
        ' Fire off asynchronous tasks
        Page.ExecuteRegisteredAsyncTasks()
    End Sub
 
    Private Function BeginGetData(ByVal sender As Object, ByVal e As EventArgs, ByVal callback As AsyncCallback, ByVal state As Object) As IAsyncResult
        ' Show Page Thread ID
        Trace.Warn("BeginGetData: " & Thread.CurrentThread.GetHashCode())
 
        ' Execute asynchronous command
        Return dataLayer.BeginGetMovies(callback, state)
    End Function
 
    Private Sub EndGetData(ByVal ar As IAsyncResult)
        ' Show Page Thread ID
        Trace.Warn("EndGetDate: " & Thread.CurrentThread.GetHashCode())
 
        ' Bind results
        grdMovies.DataSource = dataLayer.EndGetMovies(ar)
        grdMovies.DataBind()
    End Sub
 
    Private Sub TimeoutData(ByVal ar As IAsyncResult)
        ' Display error message        
        lblError.Text = "Could not retrieve data!"
    End Sub

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
