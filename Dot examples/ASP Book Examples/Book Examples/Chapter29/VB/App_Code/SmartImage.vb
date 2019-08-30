Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.Design
Imports System.ComponentModel
Imports System.ComponentModel.Design

Namespace myControls

    <Designer(GetType(SmartImageDesigner))> _
    Public Class SmartImage
        Inherits WebControl

        Private _imageUrl As String
        Private _alternateText As String
        Private _rotation As Integer = 0
        Private _mirror As Boolean = False

        Public Property ImageUrl() As String
            Get
                Return _imageUrl
            End Get
            Set(ByVal Value As String)
                _imageUrl = Value
            End Set
        End Property

        Public Property AlternateText() As String
            Get
                Return _alternateText
            End Get
            Set(ByVal Value As String)
                _alternateText = Value
            End Set
        End Property

        Public Property Rotation() As Integer
            Get
                Return _rotation
            End Get
            Set(ByVal Value As Integer)
                _rotation = Value
            End Set
        End Property

        Public Property Mirror() As Boolean
            Get
                Return _mirror
            End Get
            Set(ByVal Value As Boolean)
                _mirror = Value
            End Set
        End Property

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Img
            End Get
        End Property

        Private Function GetFilterString() As String
            Dim _mirrorValue As String = "0"
            If _mirror Then
                _mirrorValue = "1"
            End If
            Return String.Format("progid:DXImageTransform.Microsoft.BasicImage(Rotation={0},Mirror={1})", _rotation, _mirrorValue)
        End Function

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, Me.GetFilterString())
            writer.AddAttribute(HtmlTextWriterAttribute.Src, _imageUrl)
            writer.AddAttribute(HtmlTextWriterAttribute.Alt, _alternateText)
            MyBase.AddAttributesToRender(writer)
        End Sub
    End Class

    Public Class SmartImageDesigner
        Inherits ControlDesigner
        Public Overrides ReadOnly Property ActionLists() As DesignerActionListCollection
            Get
                Dim colActions As New DesignerActionListCollection()
                colActions.AddRange(MyBase.ActionLists)
                colActions.Add(New SmartImageActionList(Me))
                Return colActions
            End Get
        End Property
    End Class

    Public Class SmartImageActionList
        Inherits DesignerActionList

        Private items As DesignerActionItemCollection
        Private _parent As SmartImageDesigner

        Public Sub New(ByVal parent As SmartImageDesigner)
            MyBase.New(parent.Component)
            _parent = parent
        End Sub

        Public Sub Rotate()

            Dim toCall As TransactedChangeCallback = New TransactedChangeCallback(AddressOf DoRotate)
            ControlDesigner.InvokeTransactedChange(Me.Component, toCall, "Rotate", "Rotate image 90 degrees")
        End Sub

        Public Sub Mirror()
            Dim toCall As TransactedChangeCallback = New TransactedChangeCallback(AddressOf DoMirror)
            ControlDesigner.InvokeTransactedChange(Me.Component, toCall, "Mirror", "Mirror Image")
        End Sub

        Public Overrides Function GetSortedActionItems() As DesignerActionItemCollection
            If IsNothing(items) Then
                items = New DesignerActionItemCollection()
                items.Add(New DesignerActionMethodItem(Me, "Rotate", "Rotate Image", True))
                items.Add(New DesignerActionMethodItem(Me, "Mirror", "Mirror Image", True))
            End If
            Return items
        End Function

        Public Function DoRotate(ByVal arg As Object) As Boolean
            Dim img As SmartImage = CType(Me.Component, SmartImage)
            img.Rotation += 1
            If img.Rotation > 3 Then
                img.Rotation = 0
            End If
            _parent.UpdateDesignTimeHtml()
            Return True
        End Function

        Public Function DoMirror(ByVal arg As Object) As Boolean
            Dim img As SmartImage = CType(Me.Component, SmartImage)
            img.Mirror = Not img.Mirror
            _parent.UpdateDesignTimeHtml()
            Return True
        End Function
    End Class
End Namespace

