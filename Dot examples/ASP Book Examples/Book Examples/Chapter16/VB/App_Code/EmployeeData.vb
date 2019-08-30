Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Web.Configuration

Public Class EmployeeData

    Dim _connectionString As String

    Public Sub UpdateEmployee(ByVal employeeToUpdate As CompanyEmployee)
        ' Initialize ADO.NET objects
        Dim con As SqlConnection = New SqlConnection(_connectionString)
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.CommandText = "UPDATE Employees SET FirstName=@FirstName," _
            + "LastName=@LastName,Phone=@Phone WHERE Id=@Id"
        cmd.Connection = con

        ' Create parameters
        cmd.Parameters.AddWithValue("@Id", employeeToUpdate.Id)
        cmd.Parameters.AddWithValue("@FirstName", employeeToUpdate.FirstName)
        cmd.Parameters.AddWithValue("@LastName", employeeToUpdate.LastName)
        cmd.Parameters.AddWithValue("@Phone", employeeToUpdate.Phone)

        ' Execute command
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Public Function GetEmployees() As List(Of CompanyEmployee)
        Dim employees As New List(Of CompanyEmployee)()

        Dim con As SqlConnection = New SqlConnection(_connectionString)
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.CommandText = "SELECT Id,FirstName,LastName,Phone FROM Employees"
        cmd.Connection = con
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                Dim NewEmployee As New CompanyEmployee()
                NewEmployee.Id = CType(reader("Id"), Integer)
                NewEmployee.FirstName = CType(reader("FirstName"), String)
                NewEmployee.LastName = CType(reader("LastName"), String)
                NewEmployee.Phone = CType(reader("Phone"), String)
                employees.Add(NewEmployee)
            End While
        End Using
        Return employees
    End Function

    Public Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Employees").ConnectionString
    End Sub

End Class

Public Class CompanyEmployee
    Private _id As Integer
    Private _firstName As String
    Private _lastName As String
    Private _phone As String

    Public Property Id() As Integer
        Get
            Return _id
        End Get
        Set(ByVal Value As Integer)
            _id = Value
        End Set
    End Property

    Public Property FirstName() As String
        Get
            Return _firstName
        End Get
        Set(ByVal Value As String)
            _firstName = Value
        End Set
    End Property

    Public Property LastName() As String
        Get
            Return _lastName
        End Get
        Set(ByVal Value As String)
            _lastName = Value
        End Set
    End Property

    Public Property Phone() As String
        Get
            Return _phone
        End Get
        Set(ByVal Value As String)
            _phone = Value
        End Set
    End Property

End Class

