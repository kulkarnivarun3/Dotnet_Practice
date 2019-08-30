<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>AdRotator Database</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:AdRotator
        id="AdRotator1"
        DataSourceID="srcAds"
        Runat="server" />

    <asp:SqlDataSource
        id="srcAds"
        ConnectionString="Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|AdListDB.mdf;User Instance=True"
        SelectCommand="SELECT ImageUrl, Width, Height, NavigateUrl, AlternateText, Keyword, Impressions
            FROM AdList"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
