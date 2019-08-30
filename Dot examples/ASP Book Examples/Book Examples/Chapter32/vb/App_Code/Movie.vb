Imports System
Imports System.Collections
Imports System.Linq

Partial Public Class Movie

    Public Shared Function [Select]() As IEnumerable
        Dim db As New MyDatabaseDataContext()
        Return db.Movies.Select(Function(m) New With {m.Id, m.Title, m.Director})
    End Function

    Public Shared Sub Insert(ByVal title As String, ByVal director As String)
        Dim db As New MyDatabaseDataContext()
        Dim movieToAdd As New Movie()
        movieToAdd.Title = title
        movieToAdd.Director = director
        movieToAdd.CategoryId = 1
        movieToAdd.DateReleased = DateTime.Now
        db.Movies.InsertOnSubmit(movieToAdd)
        db.SubmitChanges()
    End Sub

End Class
