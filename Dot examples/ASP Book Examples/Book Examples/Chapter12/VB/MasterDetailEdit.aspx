<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    Private Sub Page_Load()
        If Not Page.IsPostBack Then
            grdMovies.SelectedIndex = 0
        End If
    End Sub
 
    Protected Sub dtlMovies_ItemUpdated(ByVal sender As Object, ByVal e As DetailsViewUpdatedEventArgs)
        grdMovies.DataBind()
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
            font:14px Georgia,Serif;
        }
        .content
        {
            margin:auto;
            width:600px;
            background-color:white;
        }
        .column
        {
            float:left;
            width:250px;
        }
        .selectedRow
        {
            background-color:yellow;
        }
    </style>
    <title>Master/Detail Edit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">

    <div class="column">
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id"
        AutoGenerateSelectButton="true"
        SelectedRowStyle-CssClass="selectedRow"
        Runat="server" />
    </div>
    
    <div class="column">
    <asp:DetailsView
        id="dtlMovies"
        DefaultMode="Edit"
        AutoGenerateEditButton="true"
        AllowPaging="true"
        DataSourceID="srcMovieDetails"
        DataKeyNames="Id"
        OnItemUpdated="dtlMovies_ItemUpdated"
        Runat="server" />
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title FROM Movies"
        Runat="server" />
    </div>
    
    <asp:SqlDataSource
        id="srcMovieDetails"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT Id,Title,Director,InTheaters FROM
            Movies WHERE Id=@MovieId"
        UpdateCommand="UPDATE Movies SET Title=@Title,Director=@Director,
            InTheaters=@InTheaters WHERE Id=@Id"
        Runat="server">
        <SelectParameters>
            <asp:ControlParameter Name="MovieId" ControlID="grdMovies" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
