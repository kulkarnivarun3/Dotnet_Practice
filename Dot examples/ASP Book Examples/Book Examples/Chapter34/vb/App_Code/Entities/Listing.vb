Imports System
Imports System.Linq
Imports System.Data.Linq.Mapping
Imports System.Collections.Generic

Partial Public Class Listing
     Inherits EntityBase(Of Listing)


    Public Shared Function SelectByChapterId(ByVal chapterId As Integer) As IEnumerable(Of EnTry)
        Return Table _
            .Where(Function(l) l.ChapterId = chapterId) _
            .OrderBy(Function(l) l.OrderNumber) _
            .Join(Entry.Table, Function(l) l.EntryId, Function(e) e.Id, Function(l, e) e)


    End Function

    Protected Overrides Sub Validate()
    End Sub

End Class

