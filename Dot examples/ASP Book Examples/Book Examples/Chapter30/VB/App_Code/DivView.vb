Imports System
Imports System.Collections
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace AspNetUnleashed
    Public Class DivView
        Inherits CompositeDataBoundControl

        Private _itemTemplate As ITemplate

        <TemplateContainer(GetType(DivViewItem))> _
        <PersistenceMode(PersistenceMode.InnerProperty)> _
        Public Property ItemTemplate() As ITemplate
            Get
                Return _itemTemplate
            End Get
            Set(ByVal Value As ITemplate)
                _itemTemplate = Value
            End Set
        End Property

        Protected Overrides Function CreateChildControls(ByVal dataSource As IEnumerable, ByVal dataBinding As Boolean) As Integer
            Dim counter As Integer = 0
            For Each dataItem As Object In dataSource
                Dim contentItem As New DivViewItem(dataItem, counter)
                _itemTemplate.InstantiateIn(contentItem)
                Controls.Add(contentItem)
                counter = counter + 1
            Next
            DataBind(False)
            Return counter
        End Function

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property
    End Class


    Public Class DivViewItem
        Inherits WebControl
        Implements IDataItemContainer

        Private _dataItem As Object
        Private _index As Integer


        Public ReadOnly Property DataItem() As Object Implements IDataItemContainer.DataItem
            Get
                Return _dataItem
            End Get
        End Property

        Public ReadOnly Property DataItemIndex() As Integer Implements IDataItemContainer.DataItemIndex
            Get
                Return _index
            End Get
        End Property

        Public ReadOnly Property DisplayIndex() As Integer Implements IDataItemContainer.DisplayIndex
            Get
                Return _index
            End Get
        End Property

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

        Public Sub New(ByVal dataItem As Object, ByVal index As Integer)
            _dataItem = dataItem
            _index = index
        End Sub

    End Class
End Namespace

