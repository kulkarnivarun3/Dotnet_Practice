<%@ Page Language="C#" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show ValidatedField</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataKeyNames="Id"   
        DataSourceID="srcMovies"
        AutoGenerateEditButton="true"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <custom:ValidatedField
            DataField="Title"
            HeaderText="Movie Title" />
        <custom:ValidatedField
            DataField="DateReleased"
            DataFormatString="{0:D}"
            HtmlEncode="false"
            ValidationDataType="Date"
            HeaderText="Date Released" />
        <custom:ValidatedField
            DataField="BoxOfficeTotals"
            DataFormatString="{0:c}"
            HtmlEncode="false"
            ValidationDataType="Currency"
            HeaderText="Box Office Totals" />
        </Columns>
    </asp:GridView>    
    
    <asp:SqlDataSource
        id="srcMovies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        SelectCommand="SELECT * FROM Movies"
        UpdateCommand="UPDATE Movies SET Title=@Title,
            DateReleased=@DateReleased, BoxOfficeTotals=@BoxOfficeTotals
            WHERE Id=@Id"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
