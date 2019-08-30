<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Web Service Method</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $addHandler( $get("btnGet"), "click", getQuote );
      }
    
      function getQuote()
      {
        QuotationService.GetQuote(getQuoteSuccess, getQuoteFail);
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
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference 
                InlineScript="true" 
                Path="~/Services/QuotationService.asmx" />
        </Services>
        </asp:ScriptManager>
    
        <input id="btnGet" type="button" value="Get Quote" />
        <br /><br />
        <span id="spanQuote"></span>
    
    </div>
    </form>
</body>
</html>
