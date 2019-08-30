Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Data.Linq
Imports System.Web

Public Class MoviesDSPaging

    Public Shared Function GetMovies(ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As IEnumerable(Of Movie)
        Dim db As New MyDatabaseDataContext()
        Return db.Movies.Skip(startRowIndex).Take(maximumRows)
    End Function


    Public Shared Function GetMovieCount() As Integer
        Dim context As HttpContext = HttpContext.Current
        If IsNothing(context.Cache("MovieCount")) Then
            context.Cache("MovieCount") = GetMovieCountFromDB()
        End If
        Return CType(context.Cache("MovieCount"), Integer)
    End Function

    Private Shared Function GetMovieCountFromDB() As Integer
        Dim db As New MyDatabaseDataContext()
        Return db.Movies.Count()
    End Function

End Class
