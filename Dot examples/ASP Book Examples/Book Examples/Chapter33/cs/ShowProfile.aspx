<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="html1" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Profile</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        // Increment page views
        Sys.Services.ProfileService.properties.pageViews ++;

        // Save profile
        Sys.Services.ProfileService.save(["pageViews"], saveSuccess);
        
        // Show page views
        $get("spanPageViews").innerHTML = Sys.Services.ProfileService.properties.pageViews; 
    
        // Change background color
        var backgroundColor = Sys.Services.ProfileService.properties["backgroundColor"];
        $get("html1").style.backgroundColor = backgroundColor;
      }
      
      function saveSuccess(countOfPropertiesSaved)
      {
        Sys.Debug.trace("Profile properties saved: " + countOfPropertiesSaved);
      }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            <ProfileService 
                LoadProperties="pageViews,backgroundColor" />
        </asp:ScriptManager>

        Your total page views:
        <span id="spanPageViews"></span> 
    </div>
    </form>
</body>
</html>
