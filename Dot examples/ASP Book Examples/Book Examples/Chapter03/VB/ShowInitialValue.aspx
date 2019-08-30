<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Page.IsValid Then
            lblResult.Text = dropFavoriteColor.SelectedValue
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Initial Value</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label
        id="lblFavoriteColor"
        Text="Favorite Color:"
        AssociatedControlID="dropFavoriteColor"
        Runat="server" />
    <br />
    <asp:DropDownList
        id="dropFavoriteColor"
        Runat="server">
        <asp:ListItem Text="Select Color" Value="none" />
        <asp:ListItem Text="Red" Value="Red" />    
        <asp:ListItem Text="Blue" Value="Blue" />    
        <asp:ListItem Text="Green" Value="Green" />    
    </asp:DropDownList>
    <asp:RequiredFieldValidator
        id="reqFavoriteColor"
        Text="(Required)"
        InitialValue="none"
        ControlToValidate="dropFavoriteColor"
        Runat="server" />
        
    <br /><br />
    
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" OnClick="btnSubmit_Click" />
    
    <hr />
    
    <asp:Label
        id="lblResult"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
