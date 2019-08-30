Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.Design
Imports System.ComponentModel
Imports System.Drawing

Namespace myControls
    <Designer(GetType(GradientPanelDesigner))> _
    <ParseChildren(False)> _
    Public Class GradientPanel
        Inherits WebControl

        Private _direction As GradientDirection = GradientDirection.Horizontal
        Private _startColor As Color = Color.DarkBlue
        Private _endColor As Color = Color.White

        Public Property Direction() As GradientDirection
            Get
                Return _direction
            End Get
            Set(ByVal Value As GradientDirection)
                _direction = Value
            End Set
        End Property

        Public Property StartColor() As Color
            Get
                Return _startColor
            End Get
            Set(ByVal Value As Color)
                _startColor = Value
            End Set
        End Property

        Public Property EndColor() As Color
            Get
                Return _endColor
            End Get
            Set(ByVal Value As Color)
                _endColor = Value
            End Set
        End Property

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, Me.GetFilterString())
            MyBase.AddAttributesToRender(writer)
        End Sub

        Public Function GetFilterString() As String
            Return String.Format("progid:DXImageTransform.Microsoft.Gradient(gradientType={0},startColorStr={1},endColorStr={2})", _direction.ToString("d"), ColorTranslator.ToHtml(_startColor), ColorTranslator.ToHtml(_endColor))
        End Function

        Public Sub New()
            Me.Width = Unit.Parse("500px")
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property
    End Class

    Public Enum GradientDirection
        Vertical = 0
        Horizontal = 1
    End Enum

    Public Class GradientPanelDesigner
        Inherits ContainerControlDesigner

        Protected Overrides Sub AddDesignTimeCssAttributes(ByVal styleAttributes As System.Collections.IDictionary)
            Dim gPanel As GradientPanel = CType(Me.Component, GradientPanel)
            styleAttributes.Add("filter", gPanel.GetFilterString())
            MyBase.AddDesignTimeCssAttributes(styleAttributes)
        End Sub
    End Class
End Namespace
