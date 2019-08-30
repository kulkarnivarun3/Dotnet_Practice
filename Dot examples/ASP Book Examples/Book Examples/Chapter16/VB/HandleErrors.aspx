<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    Protected  Sub srcMovies_Inserted(ByVal sender As Object, ByVal e As ObjectDataSourceStatusEventArgs)
        If Not e.Exception Is Nothing Then
            e.ExceptionHandled = True
            lblError.Text = "Could not insert movie"
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        html
        {
            background-color:silver;
        }
        .insertForm
        {
            background-color:white;
        }
        .insertForm td,.insertForm th
        {
            padding:10px;
        }
        .error
        {
            color:red;
            font:bold 14px Arial,Sans-Serif;
        }
    </style>
    <title>Handle Errors</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblError"
        EnableViewState="false"
        CssClass="error" 
        Runat="server" />
    
    <h1>Insert Movie</h1>
    <asp:DetailsView
        id="dtlMovies"
        DataSourceID="srcMovies"
        DefaultMode="Insert"
        AutoGenerateInsertButton="true"
        AutoGenerateRows="false"
        CssClass="insertForm"
        GridLines="None"
        Runat="server">
        <Fields>
        <asp:BoundField
            DataField="Title" 
            HeaderText="Title:"/>
        <asp:BoundField
            DataField="Director"
            HeaderText="Director:" />    
        </Fields>
    </asp:DetailsView>        
    
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="InsertMovie"
        InsertMethod="Insert"
        Runat="server" OnInserted="srcMovies_Inserted" />
    
    </div>
    </form>
</body>
</html>
