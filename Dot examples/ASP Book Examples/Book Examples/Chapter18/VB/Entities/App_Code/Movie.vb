Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Data.Linq

Partial Public Class Movie

    Public Shared Function [Select]() As IEnumerable(Of Movie)
        Dim db As New MyDatabaseDataContext()
        Return db.Movies
    End Function

    Public Shared Function SelectByBoxOfficeTotals() As IEnumerable(Of Movie)
        Return [Select]().OrderBy(Function(m) m.BoxOfficeTotals)
    End Function

End Class
