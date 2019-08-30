Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace MyControls

    Public Class UsernameParameter
        Inherits Parameter
        Protected Overrides Function Evaluate(ByVal context As HttpContext, ByVal control As Control) As Object
            If Not context Is Nothing Then
                Return context.User.Identity.Name
            Else
                Return Nothing
            End If
        End Function

    End Class

End Namespace

