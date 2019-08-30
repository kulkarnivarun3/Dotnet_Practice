Imports System
Imports System.Text
Imports System.Collections.Generic
Imports System.Runtime.Serialization


''' <summary>
''' Summary description for ValidationException
''' </summary>
Public Class ValidationException
    Inherits Exception

    Private _Entity As EntityBase

    Public ReadOnly Property Entity() As EntityBase
        Get
            Return _Entity
        End Get
    End Property


    Public Overrides ReadOnly Property Message() As String
        Get
            Dim builder As New StringBuilder()
            builder.AppendLine(MyBase.Message)

            If Not IsNothing(_Entity.ValidationErrors) Then
                For Each err As ValidationError In _Entity.ValidationErrors.Values
                    builder.AppendLine("  " & err.ErrorMessage)
                Next
            End If
            Return builder.ToString()
        End Get
    End Property



    Public Sub New(ByVal message As String, ByVal entity As EntityBase)
        MyBase.New(message)
        _Entity = entity
    End Sub


End Class
