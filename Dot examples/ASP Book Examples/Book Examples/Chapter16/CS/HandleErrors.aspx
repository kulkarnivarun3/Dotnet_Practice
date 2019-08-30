<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">

    protected void srcMovies_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            lblError.Text = "Could not insert movie";
        }
    }
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
