Imports System
Imports System.Configuration

Namespace AspNetUnleashed
    Public Class AdminUsersSection
        Inherits ConfigurationSection

        <ConfigurationProperty("", IsDefaultCollection:=True)> _
        Public ReadOnly Property Users() As AdminUsersCollection
            Get
                Return CType(Me(""), AdminUsersCollection)
            End Get
        End Property

        Public Sub New()
        End Sub
    End Class

    Public Class AdminUsersCollection
        Inherits ConfigurationElementCollection

        Protected Overrides Function CreateNewElement() As ConfigurationElement
            Return New AdminUser()
        End Function

        Protected Overrides Function GetElementKey(ByVal element As ConfigurationElement) As Object
            Return (CType(element, AdminUser)).Name
        End Function

        Public Sub New()
            Me.AddElementName = "user"
        End Sub
    End Class

    Public Class AdminUser
        Inherits ConfigurationElement

        <ConfigurationProperty("name", IsRequired:=True, IsKey:=True)> _
        Public Property Name() As String
            Get
                Return CType(Me("name"), String)
            End Get
            Set(ByVal Value As String)
                Me("name") = Value
            End Set
        End Property

        <ConfigurationProperty("password", IsRequired:=True)> _
        Public Property Password() As String
            Get
                Return CType(Me("password"), String)
            End Get
            Set(ByVal Value As String)
                Me("password") = Value
            End Set
        End Property
    End Class
End Namespace

