Imports System
Imports System.Linq
Imports System.Collections.Generic
Imports System.Data.Linq.Mapping
Imports System.Data.Linq

''' <summary>
''' Summary description for Chapter
''' </summary>
Partial Public Class Chapter
     Inherits EntityBase(Of Chapter)

    Public Shared Function SelectByBookId(ByVal bookId As Integer) As IEnumerable(Of Chapter)
        Return Table.Where(Function(c) c.BookId = bookId).OrderBy(Function(c) c.OrderNumber)
    End Function



    Protected Overrides Sub Validate()
        If Not ValidationUtility.SatisfiesRequired(Title) Then
            ValidationErrors.Add("Title", "Title is required", "required")
        End If
        If Not ValidationUtility.SatisfiesRequired(Description) Then
            ValidationErrors.Add("Description", "Description is required", "required")
        End If
    End Sub





End Class

