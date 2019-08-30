<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    [System.Web.Services.WebMethod]
    public static string GetQuote()
    {
        List<string> quotes = new List<string>();
        quotes.Add("The fool who is silent passes for wise.");
        quotes.Add("The early bird catches the worm.");
        quotes.Add("If wishes were true, shepherds would be kings.");
        Random rnd = new Random();
        return quotes[rnd.Next(quotes.Count)];    
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Page Method</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $addHandler( $get("btnGet"), "click", getQuote );
      }
    
      function getQuote()
      {
       PageMethods.GetQuote(getQuoteSuccess, getQuoteFail);
      }
    
      function getQuoteSuccess(result)
      {
        $get("spanQuote").innerHTML = result;
      }
      
      function getQuoteFail(error)
      {
        alert(error.get_message());
      }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager 
        ID="ScriptManager1" 
        EnablePageMethods="true" 
        runat="server" />

    <input id="btnGet" type="button" value="Get Quote" />
    <br /><br />
    <span id="spanQuote"></span>
    </form>
</body>
</html>
