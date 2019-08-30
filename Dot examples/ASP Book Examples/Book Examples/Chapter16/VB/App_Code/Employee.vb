Imports System.Collections.Generic
Imports System.Linq
Imports System.Data.Linq

Partial Public Class Employee
    Public Shared Function [Select]() As IEnumerable(Of Employee)
        Dim db As New EmployeesDataContext()
        Return db.Employees.OrderBy(Function(e) e.LastName)
    End Function
End Class
