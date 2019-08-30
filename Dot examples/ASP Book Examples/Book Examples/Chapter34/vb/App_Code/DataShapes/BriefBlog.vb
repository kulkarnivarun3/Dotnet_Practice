Imports System

''' <summary>
''' Summary description for BriefBlog
''' </summary>
Public Class BriefBlog

    Private _Id As Integer
    Public Property Id() As Integer
    Get
        Return _Id
    End Get
    Set(ByVal value As Integer)
        _Id = value
    End Set
    End Property

    Private _Title As String
    Public Property Title() As String
    Get
        Return _Title
    End Get
    Set(ByVal value As String)
        _Title = value
    End Set
    End Property

    Private _AuthorUserName As String
    Public Property AuthorUserName() As String
    Get
        Return _AuthorUserName
    End Get
    Set(ByVal value As String)
        _AuthorUserName = value
    End Set
    End Property

    Private _IntroductionText As String
    Public Property IntroductionText() As String
    Get
        Return _IntroductionText
    End Get
    Set(ByVal value As String)
        _IntroductionText = value
    End Set
    End Property

    Private _DateCreated As DateTime
    Public Property DateCreated() As DateTime
    Get
        Return _DateCreated
    End Get
    Set(ByVal value As DateTime)
        _DateCreated = value
    End Set
    End Property

    Private _FirstName As String
    Public Property FirstName() As String
    Get
        Return _FirstName
    End Get
    Set(ByVal value As String)
        _FirstName = value
    End Set
    End Property

    Private _LastName As String
    Public Property LastName() As String
    Get
        Return _LastName
    End Get
    Set(ByVal value As String)
        _LastName = value
    End Set
    End Property

    Private _CommentCount As Integer
    Public Property CommentCount() As Integer
    Get
        Return _CommentCount
    End Get
    Set(ByVal value As Integer)
        _CommentCount = value
    End Set
    End Property

    Private _IsPinned As Boolean
    Public Property IsPinned() As Boolean
    Get
        Return _IsPinned
    End Get
    Set(ByVal value As Boolean)
        _IsPinned = value
    End Set
    End Property

    Private _Version As Byte()
    Public Property Version() As Byte()
    Get
        Return _Version
    End Get
    Set(ByVal value As Byte())
        _Version = value
    End Set
    End Property

    Public Sub New()
    End Sub
End Class

