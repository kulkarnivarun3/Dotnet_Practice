Imports System
Imports System.Web.UI.WebControls

Namespace myControls
    Public Class RequiredTextBox
        Inherits CompositeControl

        Private input As TextBox

        Private validator As RequiredFieldValidator

        Public Property Text() As String
            Get
                EnsureChildControls()
                Return input.Text
            End Get
            Set(ByVal Value As String)
                EnsureChildControls()
                input.Text = value
            End Set
        End Property

        Protected Overrides Sub CreateChildControls()
            input = New TextBox()
            input.ID = "input"
            Me.Controls.Add(input)

            validator = New RequiredFieldValidator()
            validator.ID = "valInput"
            validator.ControlToValidate = input.ID
            validator.ErrorMessage = "(Required)"
            validator.Display = ValidatorDisplay.Dynamic
            Me.Controls.Add(validator)
        End Sub

    End Class
End Namespace
