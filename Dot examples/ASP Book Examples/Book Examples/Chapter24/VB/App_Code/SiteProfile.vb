Imports System
Imports System.Web.Profile

Public Class SiteProfile
    Inherits ProfileBase

    Private _firstName As String = "Your First Name"
    Private _lastName As String = "Your Last Name"

    <SettingsAllowAnonymous(True)> _
    Public Property FirstName() As String
        Get
            Return _firstName
        End Get
        Set(ByVal Value As String)
            _firstName = value
        End Set
    End Property

    <SettingsAllowAnonymous(True)> _
    Public Property LastName() As String
        Get
            Return _lastName
        End Get
        Set(ByVal Value As String)
            _lastName = value
        End Set
    End Property
End Class

