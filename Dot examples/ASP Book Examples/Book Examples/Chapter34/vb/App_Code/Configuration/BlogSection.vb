Imports System
Imports System.Configuration
Imports System.Web.Configuration

''' <summary>
''' Summary description for BlogSection
''' </summary>
Public Class BlogSection
     Inherits ConfigurationSection

    <ConfigurationProperty("title", IsRequired:=True)> _
    Public Property Title() As String
        Get
             Return Me("title").ToString()
        End Get
        Set(ByVal Value As String)
             Me("title") = Value
        End Set
    End Property


    <ConfigurationProperty("description", IsRequired:=True)> _
    Public Property Description() As String
        Get
             Return Me("description").ToString()
        End Get
        Set(ByVal Value As String)
             Me("description") = Value
        End Set
    End Property


    <ConfigurationProperty("url", IsRequired:=True)> _
    Public Property Url() As String
        Get
             Return Me("url").ToString()
        End Get
        Set(ByVal Value As String)
             Me("url") = Value
        End Set
    End Property


    Public Sub New()
    End Sub
End Class

