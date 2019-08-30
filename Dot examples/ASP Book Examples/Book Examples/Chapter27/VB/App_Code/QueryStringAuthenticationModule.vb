Imports System
Imports System.Web

Namespace AspNetUnleashed
    Public Class QueryStringAuthenticationModule
        Implements IHttpModule

        Public Sub Init(ByVal app As HttpApplication) Implements IHttpModule.Init
            AddHandler app.AuthorizeRequest, AddressOf AuthorizeRequest
        End Sub

        Private Sub AuthorizeRequest(ByVal sender As Object, ByVal e As EventArgs)
            ' Get context
            Dim app As HttpApplication = CType(sender, HttpApplication)
            Dim context As HttpContext = app.Context

            ' If the request is for Login.aspx, exit
            Dim path As String = context.Request.AppRelativeCurrentExecutionFilePath
            If String.Compare(path, "~/login.aspx", True) = 0 Then
                Return
            End If

            ' Check for password
            Dim authenticated As Boolean = False
            If Not IsNothing(context.Request.QueryString("password")) Then
                If context.Request.QueryString("password") = "secret" Then
                    authenticated = True
                End If
            End If

            ' If not authenticated, redirect to login.aspx
            If Not authenticated Then
                context.Response.Redirect("~/Login.aspx")
            End If
        End Sub

        Public Sub Dispose() Implements IHttpModule.Dispose
        End Sub
    End Class
End Namespace

