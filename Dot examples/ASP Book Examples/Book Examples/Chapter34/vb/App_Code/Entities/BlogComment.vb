Imports System
Imports System.Collections
Imports System.Web
Imports System.Linq
Imports System.Data.Linq.Mapping
Imports System.Collections.Generic


''' <summary>
''' Summary description for BlogComment
''' </summary>
Partial Public Class BlogComment
     Inherits EntityBase(Of BlogComment)

    Public Shared Function [Select](ByVal blogId As Integer, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As IEnumerable
        Return Table.Where(Function(c) c.BlogId = blogId).OrderBy(Function(c) c.Id).Join(WebUser.Table, Function(c) c.AuthorUserName, Function(w) w.UserName, Function(c, w) New With {.Id = c.Id, .Title = c.Title, .Comment = c.Comment, .AuthorUserName = c.AuthorUserName, .Version = c.Version, .DateCreated = c.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName, .WebsiteUrl = w.WebsiteUrl}).OrderByDescending(Function(a) a.Id).Skip(startRowIndex).Take(maximumRows)
    End Function


    Public Shared Function SelectCountCached(ByVal blogId As Integer) As Integer
        Return Table.Where(Function(c) c.BlogId = blogId).Count()
    End Function




    Protected Overrides Sub Validate()
        ' Security check
        ' Only the administrator or original author can modify this comment
        If Not ValidationUtility.IsInRole("Administrators") Then
            If Not ValidationUtility.IsUserName(AuthorUserName) Then
                ValidationErrors.Add("AuthorUserName", "Only the original author or administrator can modify this comment")
            End If
        End If

        ' Check for required
        If Not ValidationUtility.SatisfiesRequired(Title) Then
            ValidationErrors.Add("Title", "Title is required", "Required")
        End If

        If Not ValidationUtility.SatisfiesRequired(Comment) Then
            ValidationErrors.Add("Comment", "Comment is required", "Required")
        End If
    End Sub
End Class

