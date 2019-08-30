Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    Public Class ArticleWithDefault
        Inherits CompositeControl

        Private _title As String
        Private _author As String
        Private _contents As String

        Private _itemTemplate As ITemplate

        Public Property Title() As String
            Get
                Return _title
            End Get
            Set(ByVal Value As String)
                _title = value
            End Set
        End Property

        Public Property Author() As String
            Get
                Return _author
            End Get
            Set(ByVal Value As String)
                _author = value
            End Set
        End Property

        Public Property Contents() As String
            Get
                Return _contents
            End Get
            Set(ByVal Value As String)
                _contents = value
            End Set
        End Property

        <TemplateContainer(GetType(ArticleWithDefault))> _
        <PersistenceMode(PersistenceMode.InnerProperty)> _
        Public Property ItemTemplate() As ITemplate
            Get
                Return _itemTemplate
            End Get
            Set(ByVal Value As ITemplate)
                _itemTemplate = Value
            End Set
        End Property

        Protected Overrides Sub CreateChildControls()
            If _itemTemplate Is Nothing Then
                _itemTemplate = New ArticleDefaultTemplate()
            End If
            _itemTemplate.InstantiateIn(Me)
        End Sub
    End Class

    Public Class ArticleDefaultTemplate
        Implements ITemplate

        Public Sub InstantiateIn(ByVal container As Control) Implements ITemplate.InstantiateIn
            Dim lblTitle As New Label()
            AddHandler lblTitle.DataBinding, AddressOf lblTitle_DataBinding

            Dim lblAuthor As New Label()
            AddHandler lblAuthor.DataBinding, AddressOf lblAuthor_DataBinding

            Dim lblContents As New Label()
            AddHandler lblContents.DataBinding, AddressOf lblContents_DataBinding

            container.Controls.Add(lblTitle)
            container.Controls.Add(New LiteralControl("<br />"))
            container.Controls.Add(lblAuthor)
            container.Controls.Add(New LiteralControl("<br />"))
            container.Controls.Add(lblContents)
        End Sub

        Private Sub lblTitle_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim lblTitle As Label = CType(sender, Label)
            Dim container As ArticleWithDefault = CType(lblTitle.NamingContainer, ArticleWithDefault)
            lblTitle.Text = container.Title
        End Sub

        Private Sub lblAuthor_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim lblAuthor As Label = CType(sender, Label)
            Dim container As ArticleWithDefault = CType(lblAuthor.NamingContainer, ArticleWithDefault)
            lblAuthor.Text = container.Author
        End Sub

        Private Sub lblContents_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
            Dim lblContents As Label = CType(sender, Label)
            Dim container As ArticleWithDefault = CType(lblContents.NamingContainer, ArticleWithDefault)
            lblContents.Text = container.Contents
        End Sub

    End Class

End Namespace

