Imports System
Imports System.Web.UI.WebControls
Imports System.Web.UI

namespace Superexpert.Controls


    Public Class EntityValidator
    Inherits BaseValidator

        Private _PropertyName As String

        Public Property PropertyName() As String
            Get
                Return _PropertyName
            End Get
            Set(ByVal value As String)
                _PropertyName = value
            End Set
        End Property



        Private _TypeName As String

        Public Property TypeName() As String
            Get
                Return _TypeName
            End Get
            Set(ByVal value As String)
                _TypeName = value
            End Set
        End Property


        Private _Text As String = "Invalid"

        Public Overrides Property Text() As String
            Get
                Return _Text
            End Get
            Set(ByVal value As String)
                _Text = value
            End Set
        End Property


        Protected Overrides Function ControlPropertiesValid() As Boolean
            If Not String.IsNullOrEmpty(TypeName) And String.IsNullOrEmpty(ControlToValidate) Then
                Throw New Exception("When setting TypeName, you must set ControlToValidate")
            End If
            If Not String.IsNullOrEmpty(ControlToValidate) Then
                Return MyBase.ControlPropertiesValid()
            End If
            Return True
        End Function


        Protected Overrides Function EvaluateIsValid() As Boolean
            If Not String.IsNullOrEmpty(TypeName) Then
                Dim value As String = Me.GetControlValidationValue(Me.ControlToValidate)
                Return ValidationUtility.SatisfiesType(value, TypeName)
            End If
            Return True
        End Function

        Protected Overrides Sub Render(ByVal writer As HtmlTextWriter)
            If Not IsValid Then
                MyBase.Render(writer)
            End If
        End Sub


        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            If String.IsNullOrEmpty(Text) Then
                writer.Write("Invalid value")
            Else
                writer.Write(Text)
            End If
        End Sub

    End Class

End Namespace
