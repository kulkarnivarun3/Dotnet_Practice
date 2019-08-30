<%@ Page Language="VB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
    Public Class CacheItem
        Private _key As String
        Private _value As Object
 
        Public ReadOnly Property Key() As String
            Get
                Return _key
            End Get
        End Property
 
        Public ReadOnly Property Value() As String
            Get
                Return _value.ToString()
            End Get
        End Property
 
        Public Sub New(ByVal key As String, ByVal value As Object)
            _key = key
            _value = value
        End Sub
    End Class
 
    Private Sub Page_Load()
        Dim items As New ArrayList()
        For Each item As DictionaryEntry In Cache
            items.Add(New CacheItem(item.Key.ToString(), item.Value))
        Next
 
        grdCache.DataSource = items
        grdCache.DataBind()
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .grid td, .grid th
        {
            padding:5px;
        }
    </style>
    <title>Enumerate Cache</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:GridView
        id="grdCache"
        CssClass="grid"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
