Imports System

Public Class PropertyHelloWorld

    Private _message As String

    Public Property Message() As String
        Get
            Return _message
        End Get
        Set(ByVal Value As String)
            If Value.Length > 5 Then
                Throw New Exception("Message too long!")
            End If
            _message = Value
        End Set
    End Property

    Public Function SayMessage() As String
        Return _message
    End Function

End Class
