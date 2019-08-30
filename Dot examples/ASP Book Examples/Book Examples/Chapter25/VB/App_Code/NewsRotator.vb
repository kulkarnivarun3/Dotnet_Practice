Imports System
Imports System.Data
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Generic

Namespace myControls
    Public Class NewsRotator
        Inherits WebControl

        Public Shared Function GetNews(ByVal context As HttpContext) As String
            Dim News As New List(Of String)()
            News.Add("Martians attack!")
            News.Add("Moon collides with earth!")
            News.Add("Life on Jupiter!")

            Dim rnd As Random = New Random()
            Return News(rnd.Next(News.Count))
        End Function

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            Context.Response.WriteSubstitution(AddressOf GetNews)
        End Sub

    End Class
End Namespace
