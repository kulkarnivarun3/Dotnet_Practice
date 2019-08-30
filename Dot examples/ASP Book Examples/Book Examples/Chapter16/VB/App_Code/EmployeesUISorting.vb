Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class EmployeesUISorting

    Private Shared ReadOnly _conString As String

    Public Shared Function GetEmployees() As DataSet
        ' Initialize ADO.NET objects
        Dim selectText As String = "SELECT Id,FirstName,LastName,Phone FROM Employees"
        Dim dad As New SqlDataAdapter(selectText, _conString)
        Dim dstEmployees As New DataSet()

        ' Fill the DataSet
        Using dad
            dad.Fill(dstEmployees)
        End Using
        Return dstEmployees
    End Function

    Shared Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("Employees").ConnectionString
    End Sub

End Class

