Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    Public Class Article
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

        <TemplateContainer(GetType(Article))> _
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
            _itemTemplate.InstantiateIn(Me)
        End Sub
    End Class

End Namespace
