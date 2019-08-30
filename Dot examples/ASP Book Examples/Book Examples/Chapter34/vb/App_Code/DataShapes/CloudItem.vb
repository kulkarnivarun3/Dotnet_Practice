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
''' Summary description for CloudItem
''' </summary>
Public Class CloudItem

    Private _Name As String
    Public Property Name() As String
    Get
        Return _Name
    End Get
    Set(ByVal value As String)
        _Name = value
    End Set
    End Property

    Private _Count As Integer
    Public Property Count() As Integer
    Get
        Return _Count
    End Get
    Set(ByVal value As Integer)
        _Count = value
    End Set
    End Property


End Class

