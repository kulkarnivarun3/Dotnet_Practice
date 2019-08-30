Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    ''' <summary>
    ''' Enables you to perform custom validation on both the client and server
    ''' </summary>
    Public Class AjaxValidator
        Inherits BaseValidator
        Implements ICallbackEventHandler

        Public Event ServerValidate As ServerValidateEventHandler

        Dim _controlToValidateValue As String

        Protected Overrides Sub OnPreRender(ByVal e As EventArgs)
            Dim eventRef As String = Page.ClientScript.GetCallbackEventReference(Me, "", "", "")

            ' Register include file
            Dim includeScript As String = Page.ResolveClientUrl("~/ClientScripts/AjaxValidator.js")
            Page.ClientScript.RegisterClientScriptInclude("AjaxValidator", includeScript)

            ' Register startup script
            Dim startupScript As String = String.Format("document.getElementById('{0}').evaluationfunction = 'AjaxValidatorEvaluateIsValid';", Me.ClientID)
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "AjaxValidator", startupScript, True)

            MyBase.OnPreRender(e)
        End Sub

        ''' <summary>
        ''' Only do the AJAX on browsers that support it
        ''' </summary>
        Protected Overrides Function DetermineRenderUplevel() As Boolean
            Return Context.Request.Browser.SupportsCallback
        End Function

        ''' <summary>
        ''' Server method called by client AJAX call
        ''' </summary>
        Public Function GetCallbackResult() As String Implements ICallbackEventHandler.GetCallbackResult
            Return ExecuteValidationFunction(_controlToValidateValue).ToString()
        End Function

        ''' <summary>
        ''' Return callback result to client
        ''' </summary>
        Public Sub RaiseCallbackEvent(ByVal eventArgument As String) Implements ICallbackEventHandler.RaiseCallbackEvent
            _controlToValidateValue = eventArgument
        End Sub

        ''' <summary>
        ''' Server-side method for validation
        ''' </summary>
        Protected Overrides Function EvaluateIsValid() As Boolean
            Dim controlToValidateValue As String = Me.GetControlValidationValue(Me.ControlToValidate)
            Return ExecuteValidationFunction(controlToValidateValue)
        End Function

        ''' <summary>
        ''' Performs the validation for both server and client
        ''' </summary>
        Private Function ExecuteValidationFunction(ByVal controlToValidateValue As String) As Boolean
            Dim args As New ServerValidateEventArgs(controlToValidateValue, Me.IsValid)
            RaiseEvent ServerValidate(Me, args)
            Return args.IsValid
        End Function

    End Class

End Namespace
