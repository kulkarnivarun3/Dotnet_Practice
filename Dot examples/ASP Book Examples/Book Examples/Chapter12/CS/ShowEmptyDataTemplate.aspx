<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .noMatch
        {
            background-color:#ffff66;
            padding:10px;
            font-family:Arial,Sans-Serif;
        }
        .noMatch h1
        {
            color:red;
            font-size:16px;  
            font-weight:bold;      
        }
    </style>
    <title>Show Empty Data Template</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovies"
        DataSourceID="srcMovies"
        Runat="server">
        <EmptyDataTemplate>
        <div class="noMatch">
            <h1>No Matching Results!</h1>
            Please select a different record.
        </div>
        </EmptyDataTemplate>
    </asp:DetailsView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters FROM Movies
            WHERE Id=-1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
