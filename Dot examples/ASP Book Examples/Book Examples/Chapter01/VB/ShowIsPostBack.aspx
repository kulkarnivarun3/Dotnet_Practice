<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Sub Page_Load()
        if Not Page.IsPostBack Then
            ' Create collection of items
            Dim items As New ArrayList()
            items.Add("Apples")
            items.Add("Oranges")

            ' Bind to DropDownList
            DropDownList1.DataSource = items
            DropDownList1.DataBind()
        End If
    End Sub

    Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs)
        Label1.Text = DropDownList1.SelectedItem.Text
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show IsPostBack</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DropDownList
        id="DropDownList1"
        Runat="server" />
    
    <asp:Button
        id="Button1"
        Text="Select"
        OnClick="Button1_Click" 
        Runat="server" />
    
    <br /><br />

    You selected:
    <asp:Label  
        id="Label1"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
