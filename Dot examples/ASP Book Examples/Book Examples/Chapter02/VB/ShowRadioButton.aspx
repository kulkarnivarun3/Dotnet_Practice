<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        If rdlMagazine.Checked Then
            lblResult.Text = rdlMagazine.Text
        End If
        If rdlTelevision.Checked Then
            lblResult.Text = rdlTelevision.Text
        End If
        If rdlOther.Checked Then
            lblResult.Text = rdlOther.Text
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show RadioButton</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    How did you hear about our Website?
    
    <ul>
        <li>
        <asp:RadioButton
            id="rdlMagazine"
            Text="Magazine Article"
            GroupName="Source"
            Runat="server" />
        </li>
        <li>
        <asp:RadioButton
            id="rdlTelevision"
            Text="Television Program"
            GroupName="Source"
            Runat="server" />
        </li>
        <li>
        <asp:RadioButton
            id="rdlOther"
            Text="Other Source"
            GroupName="Source"
            Runat="server" />
        </li>
    </ul>
    
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
