Imports System
Imports System.Linq
Imports System.Data.Linq
Imports System.Data.Linq.Mapping
Imports System.Collections
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.Configuration
Imports System.ServiceModel.Syndication

''' <summary>
''' Represents a blog entry
''' </summary>
Partial Public Class Blog
     Inherits EntityBase(Of Blog)
    ''' <summary>
    ''' Returns a brief blog entry (not including post) with paging 
    ''' </summary>
    Public Shared Function SelectBriefByTag(ByVal tagName As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As IEnumerable(Of BriefBlog)
        Return SelectBriefByTag(tagName).Skip(startRowIndex).Take(maximumRows)
    End Function


    ''' <summary>
    ''' Get full blog entry (including WebUser and comment count)
    ''' </summary>
    Public Shared Function GetFull(ByVal id As Integer) As FullBlog
        Return Table _
            .Where(Function(b) b.Id = id) _
            .Join(WebUser.Table, Function(b) b.AuthorUserName, Function(w) w.UserName, Function(b, w) New FullBlog() With {.Id = b.Id, .Version = b.Version, .IsPinned = b.IsPinned, .Title = b.Title, .AuthorUserName = b.AuthorUserName, .IntroductionText = b.IntroductionText, .Post = b.Post, .DateCreated = b.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName, .CommentCount = BlogComment.Table.Where(Function(c) c.BlogId = b.Id).Count()}) _
            .Single()
    End Function


    ''' <summary>
    ''' Retrieves brief blog entry filtering by blog tag
    ''' </summary>
    Public Shared Function SelectBriefByTag(ByVal tagName As String) As IEnumerable(Of BriefBlog)
        Return BlogTag.Table _
            .Where(Function(t) t.Name = tagName) _
            .Select(Function(t) t.BlogId) _
            .Join(Table, Function(id) id, Function(b) b.Id, Function(id, b) b) _
            .Join(WebUser.Table, Function(b) b.AuthorUserName, Function(w) w.UserName, Function(b, w) New BriefBlog() With {.Id = b.Id, .Title = b.Title, .AuthorUserName = b.AuthorUserName, .IntroductionText = b.IntroductionText, .DateCreated = b.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName, .CommentCount = BlogComment.Table.Where(Function(c) c.BlogId = b.Id).Count()}) _
            .OrderByDescending(Function(b) b.Id)
    End Function


    ''' <summary>
    ''' Select count of brief blog entries by tag
    ''' </summary>
    Public Shared Function SelectBriefCountByTag(ByVal tagName As String) As Integer
        Return SelectBriefByTag(tagName).Count()
    End Function



    Public Shared Function SelectBrief(ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As IEnumerable(Of BriefBlog)
        Return Table _
            .Join(WebUser.Table, Function(b) b.AuthorUserName, Function(w) w.UserName, Function(b, w) New BriefBlog() With {.Id = b.Id, .IsPinned = b.IsPinned, .Title = b.Title, .AuthorUserName = b.AuthorUserName, .IntroductionText = b.IntroductionText, .DateCreated = b.DateCreated, .FirstName = w.FirstName, .LastName = w.LastName, .CommentCount = BlogComment.Table.Where(Function(c) c.BlogId = b.Id).Count()}) _
            .OrderByDescending(Function(b) b.IsPinned) _
            .ThenByDescending(Function(b) b.Id) _
            .Skip(startRowIndex) _
            .Take(maximumRows)
    End Function


    ''' <summary>
    ''' Used for both RSS and Atom feeds
    ''' </summary>
    ''' <returns></returns>
    Public Shared Function SelectFeed() As IEnumerable(Of SyndicationItem)
        Dim config As BlogSection = CType(WebConfigurationManager.GetSection("blog"), BlogSection)
        Dim url As String = config.Url
        Dim items As List(Of Blog) = [Select]("Id Desc").ToList()
        Return items.Select(Function(b) New SyndicationItem(b.Title, b.IntroductionText, New Uri(String.Format("{0}/Blog/Default.aspx?blogId={1}", url, b.Id)), String.Format("{0}/Blog/Default.aspx?blogId={1}", url, b.Id), b.DateCreated))
    End Function


    ''' <summary>
    ''' Where all validation happens
    ''' </summary>
    Protected Overrides Sub Validate()
        ' Required fields
        If Not ValidationUtility.SatisfiesRequired(Title) Then
            ValidationErrors.Add("Title", "Required")
        End If
        If Not ValidationUtility.SatisfiesRequired(IntroductionText) Then
            ValidationErrors.Add("IntroductionText", "Required")
        End If
        If Not ValidationUtility.SatisfiesRequired(Post) Then
            ValidationErrors.Add("Post", "Required")
        End If
    End Sub
End Class

