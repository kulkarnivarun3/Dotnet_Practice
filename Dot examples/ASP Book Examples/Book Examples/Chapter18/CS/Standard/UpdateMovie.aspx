<%@ Page Language="C#" Trace="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Update Movie</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        DataKeyNames="Id,Version"
        AutoGenerateEditButton="true"
        Runat="server" />
        
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movie"
        DataObjectTypeName="Movie"
        SelectMethod="Select"
        UpdateMethod="Update"
        ConflictDetection="CompareAllValues"
        OldValuesParameterFormatString="oldMovie"
        Runat="server" />    

    </div>
    </form>
</body>
</html>
