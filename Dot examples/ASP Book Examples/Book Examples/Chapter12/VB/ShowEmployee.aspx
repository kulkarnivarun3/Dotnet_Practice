<%@ Page Language="VB" %>
<%@ Import Namespace="System.Collections.Generic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<script runat="server">
     
    ''' <summary>
    ''' Represents an employee
    ''' </summary>
    Public Class Employee
        Public _firstName As String
        Public _lastName As String
        Public _retired As Boolean
 
        Public ReadOnly Property FirstName() As String
            Get
                Return _firstName
            End Get
        End Property
 
        Public ReadOnly Property LastName() As String
            Get
                Return _lastName
            End Get
        End Property
 
        Public ReadOnly Property Retired() As Boolean
            Get
                Return _retired
            End Get
        End Property
 
        Public Sub New(ByVal firstName As String, ByVal lastName As String, ByVal retired As Boolean)
            _firstName = firstName
            _lastName = lastName
            _retired = retired
        End Sub
    End Class
 
    ''' <summary>
    ''' Load employees into DetailsView
    ''' </summary>
    Private Sub Page_Load()
        ' Create employees collection with one employee
        Dim NewEmployee As New Employee("Steve", "Walther", False)
        Dim employees As New List(Of Employee)()
        employees.Add(NewEmployee)
 
        ' Bind employees to DetailsView
        dtlMovies.DataSource = employees
        dtlMovies.DataBind()
    End Sub

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Show Employee</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:DetailsView
        id="dtlMovies"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
