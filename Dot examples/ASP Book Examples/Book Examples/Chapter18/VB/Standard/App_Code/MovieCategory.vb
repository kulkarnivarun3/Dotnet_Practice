Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Data.Linq

Partial Public Class MovieCategory

    Public Shared Function [Select]() As IEnumerable(Of MovieCategory)
        Dim db As New MyDatabaseDataContext()
        Return db.MovieCategories
    End Function



End Class
