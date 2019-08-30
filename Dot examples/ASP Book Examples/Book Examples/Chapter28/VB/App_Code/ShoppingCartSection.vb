Imports System
Imports System.Configuration

Namespace AspNetUnleashed
    Public Class ShoppingCartSection
        Inherits ConfigurationSection

        <ConfigurationProperty("maximumItems", DefaultValue:=100, IsRequired:=True)> _
        Public Property MaximumItems() As Integer
            Get
                Return CType(Me("maximumItems"), Integer)
            End Get
            Set(ByVal Value As Integer)
                Me("maximumItems") = Value
            End Set
        End Property

        <ConfigurationProperty("defaultProvider")> _
        Public Property DefaultProvider() As String
            Get
                Return CType(Me("defaultProvider"), String)
            End Get
            Set(ByVal Value As String)
                Me("defaultProvider") = value
            End Set
        End Property

        <ConfigurationProperty("providers", IsDefaultCollection:=False)> _
        Public ReadOnly Property Providers() As ProviderSettingsCollection
            Get
                Return CType(Me("providers"), ProviderSettingsCollection)
            End Get
        End Property

        Public Sub New(ByVal maximumItems As Integer, ByVal defaultProvider As String)
            Me.MaximumItems = maximumItems
            Me.DefaultProvider = defaultProvider
        End Sub

        Public Sub New()
        End Sub
    End Class
End Namespace

