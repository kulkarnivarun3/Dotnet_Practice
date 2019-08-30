<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="Superexpert.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="frmMovie"
        DataSourceId="srcMovies"
        Runat="server" />
        
    <custom:EntityDataSource
        id="srcMovies"
        TypeName="Movie"
        SelectMethod="Get"
        Runat="server">
        <SelectParameters>
            <asp:Parameter Name="Id" DefaultValue="5" />
        </SelectParameters>
    </custom:EntityDataSource>            
    
    
    </div>
    </form>
</body>
</html>
