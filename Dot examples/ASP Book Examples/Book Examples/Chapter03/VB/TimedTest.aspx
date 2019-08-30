<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        If Not Page.IsPostBack Then
            ResetStartTime()
        End If
    End Sub
    
    Protected Sub btnAgain_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        ResetStartTime()
    End Sub
    
    Sub ResetStartTime()
        Session("StartTime") = DateTime.Now
    End Sub
    
    
    Protected Sub valAnswer_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        Dim startTime As DateTime = CType(Session("StartTime"), DateTime)
        If startTime.AddSeconds(5) > DateTime.Now Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
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
