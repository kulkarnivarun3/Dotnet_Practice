Imports System
Imports System.Linq
Imports System.Data.Linq.Mapping
Imports System.Xml.Linq
Imports System.Collections
Imports System.Collections.Generic

''' <summary>
''' Summary description for Entry
''' </summary>
Partial Public Class Entry
     Inherits EntityBase(Of Entry)

    Public Shared Function SelectByTag(ByVal tag As String) As IEnumerable
        Return EntryTag.Table _
            .Where(Function(t) t.Name = tag) _
            .Join(Table, Function(t) t.EntryId, Function(e) e.Id, Function(id, e) e) _
            .Join(WebUser.Table, Function(e) e.AuthorUserName, Function(w) w.UserName, Function(e, w) New With {.Id = e.Id, .Title = e.Title, .IntroductionText = e.IntroductionText, .AuthorUserName = e.AuthorUserName, .Rating = CType(EntryRating.Table.Where(Function(r) r.EntryId = e.Id).Average(Function(r) r.Rating), Double?), .DateCreated = e.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName}) _
            .OrderByDescending(Function(e) e.Rating) _
            .Distinct()
    End Function


    Public Function GetFull(ByVal id As Integer) As Object
        ' update count
        Dim currentEntry As Entry = [Get](id)
        currentEntry.ViewCount += 1
        Context.SubmitChanges()

        ' get full record
        Return Table _
            .Where(Function(e) e.Id = id) _
            .Join(WebUser.Table, Function(e) e.AuthorUserName, Function(w) w.UserName, Function(e, w) New With {.Id = e.Id, .Version = e.Version, .ViewCount = e.ViewCount, .Title = e.Title, .AuthorUserName = e.AuthorUserName, .Description = e.Description, .Rating = CType(EntryRating.Table.Where(Function(r) r.EntryId = e.Id).Average(Function(r) r.Rating), Decimal?), .DateCreated = e.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName}) _
            .Single()
    End Function


    Public Shared Function SelectByRating() As IEnumerable
        Return Table _
            .Join(WebUser.Table, Function(e) e.AuthorUserName, Function(w) w.UserName, Function(e, w) New With {.Id = e.Id, .Title = e.Title, .IntroductionText = e.IntroductionText, .AuthorUserName = e.AuthorUserName, .Rating = CType(EntryRating.Table.Where(Function(r) r.EntryId = e.Id).Average(Function(r) r.Rating), Decimal?), .DateCreated = e.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName}) _
            .OrderByDescending(Function(e) e.Rating) _
            .Take(10)
    End Function



    Public Shared Function SelectByRecent() As IEnumerable
        Return Table _
            .Join(WebUser.Table, Function(e) e.AuthorUserName, Function(w) w.UserName, Function(e, w) New With {.Id = e.Id, .Title = e.Title, .IntroductionText = e.IntroductionText, .AuthorUserName = e.AuthorUserName, .Rating = CType(EntryRating.Table.Where(Function(r) r.EntryId = e.Id).Average(Function(r) r.Rating), Decimal?), .DateCreated = e.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName}) _
            .OrderByDescending(Function(e) e.DateCreated) _
            .Take(10)
    End Function




    Public Shared Function SelectByViews() As IEnumerable
        Return Table _
            .Join(WebUser.Table, Function(e) e.AuthorUserName, Function(w) w.UserName, Function(e, w) New With {.Id = e.Id, .ViewCount = e.ViewCount, .Title = e.Title, .IntroductionText = e.IntroductionText, .AuthorUserName = e.AuthorUserName, .Rating = CType(EntryRating.Table.Where(Function(r) r.EntryId = e.Id).Average(Function(r) r.Rating), Decimal?), .DateCreated = e.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName}) _
            .OrderByDescending(Function(e) e.ViewCount) _
            .Take(10)
    End Function



    Public Shared Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Return Table _
            .Where(Function(e) e.Title.Contains(prefixText)) _
            .Select(Function(e) e.Title) _
            .Take(count) _
            .ToArray()
    End Function


    Public Shared Function SelectByTitle(ByVal title As String) As IEnumerable(Of Entry)
        Return Table.Where(Function(e) e.Title.Contains(title))
    End Function




    Protected Overrides Sub Validate()
        ' Security check
        ' Only the administrator or original author can modify this comment
        If Not ValidationUtility.IsInRole("Administrators") Then
            If Not ValidationUtility.IsUserName(AuthorUserName) Then
                ValidationErrors.Add("AuthorUserName", "Only the original author or administrator can modify this comment")
            End If
        End If

        If Not ValidationUtility.SatisfiesRequired(Title) Then
            ValidationErrors.Add("Title", "Title is required", "required")
        End If

        If Not ValidationUtility.SatisfiesRequired(IntroductionText) Then
            ValidationErrors.Add("IntroductionText", "Introduction text is required", "required")
        End If

        If IntroductionText.Length > 300 Then
            ValidationErrors.Add("IntroductionText", "Introduction text is too long")
        End If

        If Not ValidationUtility.SatisfiesRequired(Description) Then
            ValidationErrors.Add("Description", "Description is required", "required")
        End If
    End Sub






End Class

