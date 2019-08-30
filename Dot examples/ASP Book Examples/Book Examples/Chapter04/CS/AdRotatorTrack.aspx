<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void AdRotator1_AdCreated(object sender, AdCreatedEventArgs e)
    {
        // Update Impressions
        srcAds.InsertParameters["AdId"].DefaultValue = e.AdProperties["Id"].ToString();
        srcAds.Insert();
        
        // Change NavigateUrl to redirect page
        e.NavigateUrl = "~/AdHandler.ashx?id=" + e.AdProperties["Id"].ToString();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>AdRotator Track</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:AdRotator
        id="AdRotator1"
        DataSourceID="srcAds"
        OnAdCreated="AdRotator1_AdCreated" 
        Runat="server" />
    
    
    <asp:SqlDataSource
        id="srcAds"
        ConnectionString="Server=.\SQLExpress;Integrated Security=True;
            AttachDbFileName=|DataDirectory|AdListDB.mdf;User Instance=True"
        SelectCommand="SELECT Id, ImageUrl, Width, Height, NavigateUrl, AlternateText, Keyword, Impressions
            FROM AdList"
        InsertCommand="INSERT AdStats (AdId, EntryDate, Type) VALUES (@AdId, GetDate(), 0)"    
        Runat="server">
        <InsertParameters>
        <asp:Parameter Name="AdId" Type="int32" />
        </InsertParameters>
     </asp:SqlDataSource>   

    
    </div>
    </form>
</body>
</html>
