Imports System

''' <summary>
''' Summary description for FullBlog
''' </summary>
Public Class FullBlog
    Inherits BriefBlog

    Private _Post As String
    Public Property Post() As String
    Get
        Return _Post
    End Get
    Set(ByVal value As String)
        _Post = value
    End Set
    End Property

End Class

