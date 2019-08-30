<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Protected Sub valComments_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        If args.Value.Length > 10 Then
            args.IsValid = False
        Else
            args.IsValid = True
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show CustomValidator</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblComments"
        Text="Comments:"
        AssociatedControlID="txtComments"
        Runat="server" />
    <br />    
    <asp:TextBox
        id="txtComments"
        TextMode="MultiLine"
        Columns="30"
        Rows="5"
        Runat="server" />    
    <asp:CustomValidator
        id="valComments"
        ControlToValidate="txtComments"
        Text="(Comments must be less than 10 characters)"
        OnServerValidate="valComments_ServerValidate"
        Runat="server" />
        
    <br /><br />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
