<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .grid td,.grid th
        {
            border-bottom:solid 1px black;
            padding:5px;
        }
    </style>
    <title>AdRotator Statistics</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <h1>Advertisement Statistics</h1>
    Impressions represent the number of times an advertisement has been viewed. 
    Transfers represent the number of times an advertisement has been clicked.

    <h2>Impressions</h2>

    <asp:GridView
        id="grdImpressions"
        DataSourceID="srcImpressions"
        AutoGenerateColumns="false"
        GridLines="None"
        CssClass="grid"
        Runat="server">
        <Columns>
        <asp:BoundField 
            DataField="AdId"
            HeaderText="Advertisement Id" />
        <asp:BoundField
            DataField="Impressions"
            HeaderText="Impressions" />        
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource
        id="srcImpressions"
        ConnectionString="Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|AdListDB.mdf;User Instance=True"
        SelectCommand="SELECT AdId,Count(*) As Impressions 
            FROM AdStats 
            WHERE Type=0
            GROUP BY AdId
            ORDER BY Impressions DESC"    
        Runat="server" />

    <h2>Transfers</h2>

    <asp:GridView
        id="grdTransfers"
        DataSourceID="srcTransfers"
        AutoGenerateColumns="false"
        GridLines="None"
        CssClass="grid"
        Runat="server">
        <Columns>
        <asp:BoundField 
            DataField="AdId"
            HeaderText="Advertisement Id" />
        <asp:BoundField
            DataField="Transfers"
            HeaderText="Transfers" />        
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource
        id="srcTransfers"
        ConnectionString="Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|AdListDB.mdf;User Instance=True"
        SelectCommand="SELECT AdId,Count(*) As Transfers 
            FROM AdStats 
            WHERE Type=1
            GROUP BY AdId
            ORDER BY Transfers DESC"    
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
