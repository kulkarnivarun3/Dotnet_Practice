Imports System
Imports System.Configuration
Imports System.Web.Configuration

''' <summary>
''' Summary description for ValidationSection
''' </summary>
Public Class ValidationSection
    Inherits ConfigurationSection


    <ConfigurationProperty("", IsDefaultCollection:=True)> _
    Public ReadOnly Property ValidationTypes() As ValidationTypeCollection
        Get
            Return DirectCast(Me(""), ValidationTypeCollection)
        End Get
    End Property


End Class


Public Class ValidationTypeCollection
    Inherits ConfigurationElementCollection


    Public Function [Get](ByVal typeName As String) As String
        Dim match As ValidationType = DirectCast(Me.BaseGet(typeName), ValidationType)
        If IsNothing(match) Then
            Throw New Exception(String.Format("Could not find validation type {0} in web configuration file", typeName))
        End If
        Return match.Expression
    End Function




    Protected Overrides Function CreateNewElement() As ConfigurationElement
        Return New ValidationType()
    End Function


    Protected Overrides Function GetElementKey(ByVal element As ConfigurationElement) As Object
        Return DirectCast(element, ValidationType).Name
    End Function

End Class


Public Class ValidationType
    Inherits ConfigurationElement

    <ConfigurationProperty("name", IsRequired:=True)> _
    Public Property Name() As String
        Get
            Return Me("name").ToString()
        End Get
        Set(ByVal value As String)
            Me("name") = value
        End Set
    End Property

    <ConfigurationProperty("expression", IsRequired:=True)> _
    Public Property Expression() As String
        Get
            Return Me("expression").ToString()
        End Get
        Set(ByVal value As String)
            Me("expression") = value
        End Set
    End Property

End Class