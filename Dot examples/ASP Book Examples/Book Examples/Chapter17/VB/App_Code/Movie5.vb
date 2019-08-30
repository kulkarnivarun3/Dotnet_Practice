Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class Movie5
    Private Shared ReadOnly _connectionString As String

    Private _title As String
    Private _boxOfficeTotals As Decimal

    Public Property Title() As String
        Get
            Return _title
        End Get
        Set(ByVal Value As String)
            _title = value
        End Set
    End Property

    Public Property BoxOfficeTotals() As Decimal
        Get
            Return _boxOfficeTotals
        End Get
        Set(ByVal Value As Decimal)
            _boxOfficeTotals = value
        End Set
    End Property

    Public Function GetBoxOffice(ByRef SumBoxOfficeTotals As Decimal) As List(Of Movie5)
        Dim results As New List(Of Movie5)()
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand("GetBoxOfficeTotals", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@SumBoxOfficeTotals", SqlDbType.Money).Direction = ParameterDirection.Output
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                Dim NewMovie As New Movie5()
                NewMovie.Title = CType(reader("Title"), String)
                NewMovie.BoxOfficeTotals = CType(reader("BoxOfficeTotals"), Decimal)
                results.Add(NewMovie)
            End While
            reader.Close()
            SumBoxOfficeTotals = CType(cmd.Parameters("@SumBoxOfficeTotals").Value, Decimal)

        End Using
        Return results
    End Function

    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class

