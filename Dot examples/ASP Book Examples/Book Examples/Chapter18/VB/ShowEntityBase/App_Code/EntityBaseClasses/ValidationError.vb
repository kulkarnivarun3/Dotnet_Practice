Imports System
Imports System.Data
Imports System.Configuration
Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Xml.Linq

''' <summary>
''' Summary description for ValidationError
''' </summary>
Public Class ValidationError

    Private _Text As String

    Public Property Text() As String
        Get
            Return _Text
        End Get
        Set(ByVal value As String)
            _Text = value
        End Set
    End Property


    Private _ErrorMessage As String

    Public Property ErrorMessage() As String
        Get
            Return _ErrorMessage
        End Get
        Set(ByVal value As String)
            _ErrorMessage = value
        End Set
    End Property


    Public Sub New(ByVal errorMessage As String)
        _ErrorMessage = errorMessage
        _Text = errorMessage
    End Sub

    Public Sub New(ByVal errorMessage As String, ByVal text As String)
        _ErrorMessage = errorMessage
        _Text = text
    End Sub

End Class
