Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls

    Public Class Product
        Inherits CompositeControl

        Private _itemTemplate As ITemplate
        Private _item As ProductItem

        Public Property Name() As String
            Get
                EnsureChildControls()
                Return _item.Name
            End Get
            Set(ByVal Value As String)
                EnsureChildControls()
                _item.Name = Value
            End Set
        End Property

        Public Property Price() As Decimal
            Get
                EnsureChildControls()
                Return _item.Price
            End Get
            Set(ByVal Value As Decimal)
                EnsureChildControls()
                _item.Price = Value
            End Set
        End Property

        <TemplateContainer(GetType(ProductItem))> _
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
            _item = New ProductItem()
            _itemTemplate.InstantiateIn(_item)
            Controls.Add(_item)
        End Sub
    End Class

    Public Class ProductItem
        Inherits WebControl
        Implements IDataItemContainer

        Private _name As String
        Private _price As Decimal

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal Value As String)
                _name = Value
            End Set
        End Property

        Public Property Price() As Decimal
            Get
                Return _price
            End Get
            Set(ByVal Value As Decimal)
                _price = Value
            End Set
        End Property

        Public ReadOnly Property DataItem() As Object Implements IDataItemContainer.DataItem
            Get
                Return Me
            End Get
        End Property

        Public ReadOnly Property DataItemIndex() As Integer Implements IDataItemContainer.DataItemIndex
            Get
                Return 0
            End Get
        End Property

        Public ReadOnly Property DisplayIndex() As Integer Implements IDataItemContainer.DisplayIndex
            Get
                Return 0
            End Get
        End Property
    End Class


End Namespace
