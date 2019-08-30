Imports System
Imports System.Web.Configuration
Imports System.Collections.Generic

Public Class MovieCollection

    Public Function GetMovies() As List(Of String)
        Dim movies As New List(Of String)()
        movies.Add("Star Wars")
        movies.Add("Independence Day")
        movies.Add("War of the Worlds")
        Return movies
    End Function

End Class

