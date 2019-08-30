Imports System
Imports System.Text
Imports System.Web
Imports System.IO
Imports System.Globalization

Public Class TraceWriter
    Inherits TextWriter

    Public Overrides Sub Write(ByVal value As String)
        HttpContext.Current.Trace.Warn(value)
    End Sub

    Public Overrides Sub Write(ByVal buffer As Char(), ByVal index As Integer, ByVal count As Integer)
        HttpContext.Current.Trace.Warn("Linq", New String(buffer, index, count))
    End Sub

    Public Overrides ReadOnly Property Encoding() As Encoding
        Get
            Return Encoding.Unicode
        End Get
    End Property

    Public Sub New()
        MyBase.New(CultureInfo.CurrentCulture)
    End Sub

End Class
