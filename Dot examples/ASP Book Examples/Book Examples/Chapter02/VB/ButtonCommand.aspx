<%@ Page Language="VB" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    Private groceries As New List(Of String)()

    Sub Page_Load()
        groceries.Add("Milk")
        groceries.Add("Steak")
        groceries.Add("Fish")
    End Sub

    Sub Sort_Command(ByVal sender As Object, ByVal e As CommandEventArgs)
        If e.CommandName = "Sort" Then
            Select Case e.CommandArgument.ToString()
                Case "ASC"
                    groceries.Sort(AddressOf SortASC)
                Case "DESC"
                    groceries.Sort(AddressOf SortDESC)
            End Select
        End If
    End Sub

    Sub Page_PreRender()
        bltGroceries.DataSource = groceries
        bltGroceries.DataBind()
    End Sub

    Function SortASC(ByVal x As String, ByVal y As String) As Integer
        Return String.Compare(x, y)
    End Function

    Function SortDESC(ByVal x As String, ByVal y As String) As Integer
        Return String.Compare(x, y) * -1
    End Function

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Button Command</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Button
        id="btnSortAsc"
        Text="Sort ASC"
        CommandName="Sort"
        CommandArgument="ASC"
        OnCommand="Sort_Command" 
        Runat="server" />
    
    <asp:Button
        id="btnSortDESC"
        Text="Sort DESC"
        CommandName="Sort"
        CommandArgument="DESC"
        OnCommand="Sort_Command" 
        Runat="server" />
    
    <br /><br />
    
    <asp:BulletedList
        id="bltGroceries"
        Runat="server" />

    
    
    </div>
    </form>
</body>
</html>
