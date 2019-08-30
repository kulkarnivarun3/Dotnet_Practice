<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Protected Sub valProductCode_ServerValidate(ByVal source As Object, ByVal args As ServerValidateEventArgs)
        If args.Value.Length = 4 Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Validate Empty Text</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label  
        id="lblProductCode"
        Text="Product Code:"
        AssociatedControlID="txtProductCode"
        Runat="server" />
    <br />
    <asp:TextBox
        id="txtProductCode"
        Runat="server" />
    <asp:CustomValidator
        id="valProductCode"
        ControlToValidate="txtProductCode"
        Text="(Invalid product code)"
        ValidateEmptyText="true"
        OnServerValidate="valProductCode_ServerValidate" 
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
