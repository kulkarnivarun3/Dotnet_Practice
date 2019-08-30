Imports System
Imports System.Text.RegularExpressions
Imports System.Web.Configuration
Imports System.Web
Imports System.Web.UI
Imports System.Collections
Imports System.Collections.Generic
Imports Superexpert.Controls

''' <summary>
''' Summary description for ValidationUtility
''' </summary>
Public Class ValidationUtility

        Public Shared Function SatisfiesRequired(ByVal value As Object) As Boolean
            If IsNothing(value) Then
                Return False
            End If

            If value.ToString().Trim().Length = 0 Then
                Return False
            End If

            Return True
        End Function

        Public Shared Function SatisfiesType(ByVal input As Object, ByVal typeName As String) As Boolean
            If IsNothing(input) Then
                Return False
            End If
            Return SatisfiesType(input.ToString(), typeName)
        End Function

        Public Shared Function SatisfiesType(ByVal input As String, ByVal typeName As String) As Boolean
            Dim config As ValidationSection = DirectCast(WebConfigurationManager.GetSection("validation"), ValidationSection)
            If IsNothing(config) Then
                Throw New Exception("Missing validation section in web.config")
            End If
            Dim expression As String = config.ValidationTypes.Get(typeName)
            Return SatisifiesExpression(input, expression)
        End Function


        Public Shared Function SatisifiesExpression(ByVal input As String, ByVal expression As String) As Boolean
            If String.IsNullOrEmpty(Input) Then
                Return True
            End If
            Return Regex.IsMatch(Input, expression)
        End Function


        Public Shared Function IsInRole(ByVal roleName As String) As Boolean
            Return HttpContext.Current.User.IsInRole(roleName)
        End Function


        Public Shared Function IsUserName(ByVal userName As String) As Boolean
            Return String.Compare(HttpContext.Current.User.Identity.Name, userName) = 0
        End Function



        Public Shared Sub ShowValidationErrors(ByVal page As Page, ByVal exception As Exception)
            If TypeOf (exception.GetBaseException()) Is ValidationException Then
                Dim valException As ValidationException = DirectCast(exception.GetBaseException, ValidationException)
                ShowValidationErrors(page, valException.Entity.ValidationErrors)
            Else
                Throw exception
            End If
        End Sub


        Public Shared Sub ShowValidationErrors(ByVal page As Page, ByVal errors As ValidationErrorCollection)


            ' Build map from property name to validator
            Dim validatorMap = New Dictionary(Of String, EntityValidator)()
            For Each validator As IValidator In page.Validators
                If TypeOf (validator) Is EntityValidator Then
                    Dim entityValidator As EntityValidator = DirectCast(validator, EntityValidator)
                    If validatorMap.ContainsKey(entityValidator.PropertyName) Then
                        Throw New Exception("Duplicate EntityValidator Property Name: " & entityValidator.PropertyName)
                    End If
                    validatorMap.Add(entityValidator.PropertyName, DirectCast(validator, EntityValidator))
                End If
            Next


            ' Show validation errors
            For Each propertyName As String In errors.Keys
                Dim err As ValidationError = errors(propertyName)
                Dim validator As EntityValidator = Nothing
                If validatorMap.ContainsKey(propertyName) Then
                    validator = validatorMap(propertyName)
                Else
                    validator = New EntityValidator()
                    page.Validators.Add(validator)
                End If
                validator.IsValid = False
                validator.ErrorMessage = err.ErrorMessage
                validator.Text = err.Text
            Next
        End Sub


End Class
