Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class EmployeesDSSorting

    Private Shared ReadOnly _conString As String

    Public Shared Function GetEmployees(ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As SqlDataReader
        ' Initialize connection     
        Dim con As New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "GetSortedEmployees"
        cmd.CommandType = CommandType.StoredProcedure

        ' Create parameters
        cmd.Parameters.AddWithValue("@SortExpression", sortExpression)
        cmd.Parameters.AddWithValue("@StartRowIndex", startRowIndex)
        cmd.Parameters.AddWithValue("@MaximumRows", maximumRows)

        ' Execute command
        con.Open()
        Return cmd.ExecuteReader(CommandBehavior.CloseConnection)
    End Function


    Public Shared Function GetEmployeeCount() As Integer
        Dim context As HttpContext = HttpContext.Current
        If context.Cache("EmployeeCount") Is Nothing Then
            context.Cache("EmployeeCount") = GetEmployeeCountFromDB()
        End If
        Return CType(context.Cache("EmployeeCount"), Integer)
    End Function

    Private Shared Function GetEmployeeCountFromDB() As Integer
        Dim result As Integer = 0

        ' Initialize connection     
        Dim con As SqlConnection = New SqlConnection(_conString)

        ' Initialize command
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.Connection = con
        cmd.CommandText = "SELECT Count(*) FROM Employees"

        ' Execute command
        Using con
            con.Open()
            result = CType(cmd.ExecuteScalar(), Integer)
        End Using
        Return result
    End Function



    Shared Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Employees").ConnectionString
    End Sub

End Class

