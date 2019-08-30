Imports System.Web

Public Class Preferences

    Public Shared Property FavoriteColor() As String
        Get
            Dim context As HttpContext = HttpContext.Current
            context.Trace.Warn("Getting FavoriteColor")
            If context.Session("FavoriteColor") Is Nothing Then
                Return "Blue"
            Else
                Return CType(context.Session("FavoriteColor"), String)
            End If
        End Get
        Set(ByVal Value As String)
            Dim context As HttpContext = HttpContext.Current
            context.Trace.Warn("Setting FavoriteColor")
            context.Session("FavoriteColor") = value
        End Set
    End Property


End Class

