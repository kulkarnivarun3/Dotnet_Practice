Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class DataLayer1
    Private Shared ReadOnly _connectionString As String

    Public Class MovieCategory
        Private _id As Integer
        Private _name As String

        Public Property Id() As Integer
            Get
                Return _id
            End Get
            Set(ByVal Value As Integer)
                _id = value
            End Set
        End Property

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = value
            End Set
        End Property
    End Class

    Public Class Movie
        Private _title As String
        Private _categoryId As Integer

        Public Property Title() As String
            Get
                Return _title
            End Get
            Set(ByVal Value As String)
                _title = value
            End Set
        End Property

        Public Property CategoryId() As Integer
            Get
                Return _categoryId
            End Get
            Set(ByVal Value As Integer)
                _categoryId = value
            End Set
        End Property
    End Class

    Public Shared Sub GetMovieData(ByVal movieCategories As List(Of DataLayer1.MovieCategory), ByVal movies As List(Of DataLayer1.Movie))
        Dim commandText As String = "SELECT Id,Name FROM MovieCategories;SELECT Title,CategoryId FROM Movies"
        Dim con As New SqlConnection(_connectionString)
        Dim cmd As New SqlCommand(commandText, con)
        Using con
            ' Execute command
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            ' Create movie categories
            While reader.Read()
                Dim NewCategory As New DataLayer1.MovieCategory()
                NewCategory.Id = CType(reader("Id"), Integer)
                NewCategory.Name = CType(reader("Name"), String)
                movieCategories.Add(NewCategory)
            End While

            ' Move to next result set
            reader.NextResult()

            ' Create movies
            While reader.Read()
                Dim NewMovie As DataLayer1.Movie = New DataLayer1.Movie()
                NewMovie.Title = CType(reader("Title"), String)
                NewMovie.CategoryId = CType(reader("CategoryID"), Integer)
                movies.Add(NewMovie)
            End While
        End Using
    End Sub

    Shared Sub New()
        _connectionString = WebConfigurationManager.ConnectionStrings("Movies").ConnectionString
    End Sub
End Class

