Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    ''' <summary>
    ''' Validates the length of an input field
    ''' </summary>
    Public Class LengthValidator
        Inherits BaseValidator

        Dim _maximumLength As Integer = 0

        Public Property MaximumLength() As Integer
            Get
                Return _maximumLength
            End Get
            Set(ByVal Value As Integer)
                _maximumLength = value
            End Set
        End Property

        Protected Overrides Function EvaluateIsValid() As Boolean
            Dim value As String = Me.GetControlValidationValue(Me.ControlToValidate)
            If value.Length > _maximumLength Then
                Return False
            Else
                Return True
            End If
        End Function
    End Class
End Namespace
