Imports System
Imports System.Data.SqlClient

Public Class Movie
Implements ICreatable


    Private _Id As Integer

    Public Property Id() As Integer
        Get
            Return _Id
        End Get
        Set(ByVal value As Integer)
            _Id = value
        End Set
    End Property




    Private _Title As String

    Public Property Title() As String
        Get
            Return _Title
        End Get
        Set(ByVal value As String)
            _Title = value
        End Set
    End Property


    Public Sub Create(ByVal reader As SqlDataReader) Implements ICreatable.Create
        Id = CType(reader("Id"), Integer)
        Title = CType(reader("Title"), String)
    End Sub

End Class
