<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void srcMovies_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        lblExecutionTime.Text = e.OutputParameters["executionTime"].ToString();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Movie2</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        Runat="server" />
    
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movie2"
        SelectMethod="GetAll"
        Runat="server" OnSelected="srcMovies_Selected">
        <SelectParameters>
        <asp:Parameter Name="executionTime" Type="Int64" Direction="Output" />
        </SelectParameters>
    </asp:ObjectDataSource>    
    
    <br />
    
    Execution time was
    <asp:Label
        id="lblExecutionTime"
        Runat="server" />
    milliseconds
    
    </div>
    </form>
</body>
</html>
