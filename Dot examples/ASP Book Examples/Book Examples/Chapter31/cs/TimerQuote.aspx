<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        List<string> quotes = new List<string>();
        quotes.Add("A fool and his money are soon parted");
        quotes.Add("A penny saved is a penny earned");
        quotes.Add("An apple a day keeps the doctor away");
        
        Random rnd = new Random();
        lblQuote.Text = quotes[rnd.Next(quotes.Count)];
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Timer Quote</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <asp:Timer ID="Timer1" Interval="2000" runat="server" />

    Page Time: <%= DateTime.Now.ToString("T") %>
    
    <fieldset>
    <legend>Quote</legend>
    <asp:UpdatePanel ID="up1" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
    </Triggers>
    <ContentTemplate>
        <asp:Label ID="lblQuote" runat="server" />
    </ContentTemplate>
    </asp:UpdatePanel>
    </fieldset>
        
    </div>
    </form>
</body>
</html>
