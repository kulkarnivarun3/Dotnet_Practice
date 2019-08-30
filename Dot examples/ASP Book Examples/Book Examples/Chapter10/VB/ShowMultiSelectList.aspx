<%@ Page Language="VB" %>
<%@ Register TagPrefix="custom" Namespace="myControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
    Protected  Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        For Each item As ListItem In MultiSelectList1.Items
            If item.Selected Then
                lblSelected.Text &= String.Format("<li>{0} ({1})", item.Text, item.Value)
            End If
        Next
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show MultiSelectList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <b>Movies:</b>
    <asp:RequiredFieldValidator
        id="val"
        ControlToValidate="MultiSelectList1"
        Text="Required"
        Runat="server" />        

    <custom:MultiSelectList
        id="MultiSelectList1"
        DataSourceID="srcMovies"
        DataTextField="Title"
        DataValueField="Id"
        Runat="server" />
        
            
    <asp:SqlDataSource
        id="srcMovies"
        SelectCommand="SELECT Id, Title FROM Movies"
        ConnectionString="<%$ ConnectionStrings:Movies %>"
        Runat="server" />
    
    <p>
    <asp:Button
        id="btnSubmit"
        Text="Submit"
        Runat="server" OnClick="btnSubmit_Click" />
    </p>
    
    <hr />

    <asp:Label
        id="lblSelected"
        EnableViewState="false"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
