Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls


Namespace Superexpert.Controls

    ''' <summary>
    ''' Summary description for UserNameParameter
    ''' </summary>
    Public Class UserNameParameter
     Inherits Parameter
        Protected Overrides Function Evaluate(ByVal context As HttpContext, ByVal control As Control) As Object
            Return context.User.Identity.Name
        End Function

    End Class

End Namespace

