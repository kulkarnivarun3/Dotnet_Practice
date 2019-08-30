Imports System
Imports System.Linq
Imports System.Data.Linq.Mapping
Imports System.Collections
Imports System.Collections.Generic
Imports System.Web

''' <summary>
''' Summary description for Tag
''' </summary>
Partial Public Class EntryTag
     Inherits EntityBase(Of EntryTag)

    Public Function SelectByEntryId(ByVal enTryId As Integer) As IEnumerable(Of EntryTag)
        Return Table _
            .Where(Function(t) t.EntryId = enTryId)
    End Function


    Public Shared Function SelectTagCloud() As IEnumerable(Of CloudItem)
        Return Table _
            .GroupBy(Function(t) t.Name) _
            .Select(Function(g) New CloudItem() With {.Name = g.Key, .Count = g.Count()}) _
            .OrderBy(Function(a) a.Name)
    End Function



    Public Overrides Sub Insert()
        Dim count As Integer = Table _
            .Where(Function(t) t.EntryId = EntryId) _
            .Count()
        If count < 3 Then
            MyBase.Insert()
        Else
            ValidationErrors.Add("Name", "You cannot add more than 3 tags")
        End If
    End Sub


    Public Shared Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Return Table _
            .Where(Function(t) t.Name.StartsWith(prefixText)) _
            .Select(Function(t) t.Name) _
            .Distinct() _
            .Take(count) _
            .ToArray()
    End Function




    Protected Overrides Sub Validate()
        ' Security check
        If Not ValidationUtility.IsInRole("Administrators") Then
            Dim userName As String = HttpContext.Current.User.Identity.Name
            Dim entry As Entry = entry.Table _
                .Where(Function(e) e.Id = EntryId And e.AuthorUserName = userName) _
                .SingleOrDefault()
            If entry Is Nothing Then
                ValidationErrors.Add("AuthorUserName", "Only the original author or an administrator can modify these tags")
            End If
        End If


        If Not ValidationUtility.SatisfiesRequired(Name) Then
            ValidationErrors.Add("Name", "Required")
        End If
    End Sub
End Class

