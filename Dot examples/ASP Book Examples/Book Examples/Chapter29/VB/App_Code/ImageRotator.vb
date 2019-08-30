Imports System
Imports System.Collections
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.ComponentModel

Namespace myControls

    <ParseChildren(True, "ImageItems")> _
    Public Class ImageRotator
        Inherits WebControl
        Private _imageItems As ArrayList = New ArrayList()

        Public ReadOnly Property ImageItems() As ArrayList
            Get
                Return _imageItems
            End Get
        End Property

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            Dim rnd As Random = New Random()
            Dim img As ImageItem = CType(_imageItems(rnd.Next(_imageItems.Count)), ImageItem)
            writer.AddAttribute(HtmlTextWriterAttribute.Src, img.ImageUrl)
            writer.AddAttribute(HtmlTextWriterAttribute.Alt, img.AlternateText)
            writer.RenderBeginTag(HtmlTextWriterTag.Img)
            writer.RenderEndTag()
        End Sub
    End Class

    Public Class ImageItem
        Private _imageUrl As String
        Private _alternateText As String

        Public Property ImageUrl() As String
            Get
                Return _imageUrl
            End Get
            Set(ByVal Value As String)
                _imageUrl = value
            End Set
        End Property

        Public Property AlternateText() As String
            Get
                Return _alternateText
            End Get
            Set(ByVal Value As String)
                _alternateText = value
            End Set
        End Property
    End Class
End Namespace
