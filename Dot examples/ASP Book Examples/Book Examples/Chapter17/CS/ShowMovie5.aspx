<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void srcMovies_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        decimal sum = (decimal)e.OutputParameters["SumBoxOfficeTotals"];
        lblSum.Text = sum.ToString("c");
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Movie5</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:GridView
        id="grdMovies"
        DataSourceID="srcMovies"
        AutoGenerateColumns="false"
        Runat="server">
        <Columns>
        <asp:BoundField DataField="Title" HeaderText="Title" />
        <asp:BoundField 
            DataField="BoxOfficeTotals" 
            HeaderText="Box Office" 
            HtmlEncode="false" 
            DataFormatString="{0:c}" />
        </Columns>
    </asp:GridView>    
    <br />
    Sum of Box Office Totals:
    <asp:Label
        id="lblSum"
        Runat="server" />
        
    <asp:ObjectDataSource
        id="srcMovies"
        TypeName="Movie5"
        SelectMethod="GetBoxOffice"
        Runat="server" OnSelected="srcMovies_Selected">
        <SelectParameters>
        <asp:Parameter 
            Name="SumBoxOfficeTotals"
            Type="Decimal" 
            Direction="Output" />
        </SelectParameters>
    </asp:ObjectDataSource>    
            
    
    
    </div>
    </form>
</body>
</html>
