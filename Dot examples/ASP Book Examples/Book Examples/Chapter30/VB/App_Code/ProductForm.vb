Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.ComponentModel
Imports System.Collections.Specialized

Namespace myControls

    Public Class ProductForm
        Inherits CompositeControl

        Public Event ProductUpdated As EventHandler

        Private _editItemTemplate As IBindableTemplate
        Private _item As ProductFormItem
        Private _results As IOrderedDictionary

        Public ReadOnly Property Results() As IOrderedDictionary
            Get
                Return _results
            End Get
        End Property

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

        <TemplateContainer(GetType(ProductFormItem), BindingDirection.TwoWay)> _
        <PersistenceMode(PersistenceMode.InnerProperty)> _
        Public Property EditItemTemplate() As IBindableTemplate
            Get
                Return _editItemTemplate
            End Get
            Set(ByVal Value As IBindableTemplate)
                _editItemTemplate = Value
            End Set
        End Property

        Protected Overrides Sub CreateChildControls()
            _item = New ProductFormItem()
            _editItemTemplate.InstantiateIn(_item)
            Controls.Add(_item)
        End Sub

        Protected Overrides Function OnBubbleEvent(ByVal source As Object, ByVal args As EventArgs) As Boolean
            _results = _editItemTemplate.ExtractValues(_item)
            RaiseEvent ProductUpdated(Me, EventArgs.Empty)
            Return True
        End Function
    End Class

    Public Class ProductFormItem
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

