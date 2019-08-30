Imports System
Imports System.Collections.Generic


Public Class ValidationErrorCollection
    Inherits Dictionary(Of String, ValidationError)



    Public Overloads Sub Add(ByVal propertyName As String, ByVal errorMessage As String)
        Me(propertyName) = New ValidationError(errorMessage)
    End Sub


    Public Overloads Sub Add(ByVal propertyName As String, ByVal errorMessage As String, ByVal text As String)
        Me(propertyName) = New ValidationError(errorMessage, text)
    End Sub


    ''' <summary>
    ''' If a property does not already have a validation error associated with it,
    ''' adds a new new valiation error
    ''' </summary>
    Public Sub AddIfNotAlready(ByVal propertyName As String, ByVal errorMessage As String)
        If Not Me.ContainsKey(propertyName) Then
            Add(propertyName, errorMessage)
        End If
    End Sub

    ''' <summary>
    ''' If a property does not already have a validation error associated with it,
    ''' adds a new new valiation error
    ''' </summary>
    Public Sub AddIfNotAlready(ByVal propertyName As String, ByVal errorMessage As String, ByVal text As String)
        If Not Me.ContainsKey(propertyName) Then
            Add(propertyName, errorMessage, Text)
        End If
    End Sub


End Class
