Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace MyControls

    Public Class PagePropertyParameter
        Inherits Parameter

        Private _propertyName As String

        Protected Overrides Function Evaluate(ByVal context As HttpContext, ByVal control As Control) As Object
            Return DataBinder.Eval(control.Page, PropertyName)
        End Function

        Public Property PropertyName() As String
            Get
                Return _propertyName
            End Get
            Set(ByVal Value As String)
                _propertyName = value
            End Set
        End Property

    End Class
End Namespace

