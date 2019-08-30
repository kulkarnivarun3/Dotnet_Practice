<%@ Page Language="VB" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
 
    ''' <summary>
    ''' Represents an item in the
    ''' shopping cart
    ''' </summary>
    Public Class CartItem
        Private _id As Integer
        Public _description As String
 
        Public ReadOnly Property Id() As Integer
            Get
                Return _id
            End Get
        End Property
 
        Public ReadOnly Property Description() As String
            Get
                Return _description
            End Get
        End Property
 
        Public Sub New(ByVal id As Integer, ByVal description As String)
            _id = id
            _description = description
        End Sub
    End Class
 
    Private Sub Page_Load()
        If Not IsPostBack Then
            ' Create shopping cart
            Dim shoppingCart As New List(Of CartItem)()
            shoppingCart.Add(New CartItem(1, "Notebook Computer"))
            shoppingCart.Add(New CartItem(2, "HD Plasma Television"))
            shoppingCart.Add(New CartItem(3, "Lava Lamp"))
 
            ' Bind ListBox to shopping cart
            lstShoppingCart.DataSource = shoppingCart
            lstShoppingCart.DataBind()
        End If
    End Sub
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Programmatic DataBinding</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:ListBox
        id="lstShoppingCart"
        DataTextField="Description"
        DataValueField="Id"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
