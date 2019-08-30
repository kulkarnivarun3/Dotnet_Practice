Imports System
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.Linq.Mapping
Imports System.Linq

''' <summary>
''' Summary description for BlogTag
''' </summary>
Partial Public Class BlogTag
     Inherits EntityBase(Of BlogTag)

    Public Shared Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Return Table.Where(Function(t) t.Name.StartsWith(prefixText)).Select(Function(t) t.Name).Distinct().Take(count).ToArray()
    End Function


    Public Function SelectByBlogId(ByVal blogId As Integer) As IEnumerable(Of BlogTag)
        Return Table.Where(Function(c) c.BlogId = blogId).OrderBy(Function(c) c.Name)
    End Function



    Protected Overrides Sub Validate()
        If Not ValidationUtility.SatisfiesRequired(Name) Then
            ValidationErrors.Add("Name", "Tag name is required")
        End If
    End Sub
End Class

