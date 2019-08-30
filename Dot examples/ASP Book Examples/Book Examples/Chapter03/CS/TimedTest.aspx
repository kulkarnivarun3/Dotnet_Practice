<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    void Page_Load()
    {
        if (!Page.IsPostBack)
            ResetStartTime();
    }
    
    void btnAgain_Click(Object sender, EventArgs e)
    {
        ResetStartTime();
    }
    
    void ResetStartTime()
    {
        Session["StartTime"] = DateTime.Now;
    }
    
    
    void valAnswer_ServerValidate(Object source, ServerValidateEventArgs args)
    {
        DateTime startTime = (DateTime)Session["StartTime"];
        if (startTime.AddSeconds(5) > DateTime.Now)
            args.IsValid = true;
        else
            args.IsValid = false;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Timed Test</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <p>
    You have 5 seconds to answer the following question:
    </p>
    
    <asp:Label
        id="lblQuestion"
        Text="What was Aristotle's first name?"
        AssociatedControlID="txtAnswer"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtAnswer"
        Runat="server" />    
    <asp:CustomValidator
        id="valAnswer"
        Text="(You answered too slowly!)"
        OnServerValidate="valAnswer_ServerValidate"
        Runat="server"  />
    
    <br /><br />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" />
    
    <asp:Button
        id="btnAgain"
        Text="Try Again!"
        CausesValidation="false"
        OnClick="btnAgain_Click"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
