Imports System
Imports System.Collections.Generic
Imports AcmeStore.DataAccessLayer

Namespace AcmeStore.BusinessLogicLayer

    ''' <summary>
    ''' Represents a store product and all the methods
    ''' for selecting, inserting, and updating a product
    ''' </summary>
    Public Class Product

        Private _id As Integer = 0
        Private _name As String = String.Empty
        Private _price As Decimal = 0
        Private _description As String = String.Empty

        ''' <summary>
        ''' Product Unique Identifier
        ''' </summary>
        Public ReadOnly Property Id() As Integer
            Get
                Return _id
            End Get
        End Property

        ''' <summary>
        ''' Product Name
        ''' </summary>
        Public ReadOnly Property Name() As String
            Get
                Return _name
            End Get
        End Property

        ''' <summary>
        ''' Product Price
        ''' </summary>
        Public ReadOnly Property Price() As Decimal
            Get
                Return _price
            End Get
        End Property

        ''' <summary>
        ''' Product Description
        ''' </summary>
        Public ReadOnly Property Description() As String
            Get
                Return _description
            End Get
        End Property

        ''' <summary>
        ''' Retrieves all products
        ''' </summary>
        Public Shared Function SelectAll() As List(Of Product)
            Dim dataAccessLayer As SqlDataAccessLayer = New SqlDataAccessLayer()
            Return dataAccessLayer.ProductSelectAll()
        End Function

        ''' <summary>
        ''' Updates a particular product
        ''' </summary>
        ''' <param name="id">Product Id</param>
        ''' <param name="name">Product Name</param>
        ''' <param name="price">Product Price</param>
        ''' <param name="description">Product Description</param>
        Public Shared Sub Update(ByVal id As Integer, ByVal name As String, ByVal price As Decimal, ByVal description As String)
            If id < 1 Then
                Throw New ArgumentException("Product Id must be greater than 0", "id")
            End If

            Dim productToUpdate As Product = New Product(id, name, price, description)
            productToUpdate.Save()
        End Sub

        ''' <summary>
        ''' Inserts a new product
        ''' </summary>
        ''' <param name="name">Product Name</param>
        ''' <param name="price">Product Price</param>
        ''' <param name="description">Product Description</param>
        Public Shared Sub Insert(ByVal name As String, ByVal price As Decimal, ByVal description As String)
            Dim NewProduct As Product = New Product(name, price, description)
            NewProduct.Save()
        End Sub

        ''' <summary>
        ''' Deletes an existing product
        ''' </summary>
        ''' <param name="id">Product Id</param>
        Public Shared Sub Delete(ByVal id As Integer)
            If id < 1 Then
                Throw New ArgumentException("Product Id must be greater than 0", "id")
            End If

            Dim dataAccessLayer As SqlDataAccessLayer = New SqlDataAccessLayer()
            dataAccessLayer.ProductDelete(id)
        End Sub

        ''' <summary>
        ''' Validates product information before saving product
        ''' properties to the database
        ''' </summary>
        Private Sub Save()
            If String.IsNullOrEmpty(_name) Then
                Throw New ArgumentException("Product Name not supplied", "name")
            End If
            If _name.Length > 50 Then
                Throw New ArgumentException("Product Name must be less than 50 characters", "name")
            End If
            If String.IsNullOrEmpty(_description) Then
                Throw New ArgumentException("Product Description not supplied", "description")
            End If

            Dim dataAccessLayer As SqlDataAccessLayer = New SqlDataAccessLayer()
            If _id > 0 Then
                dataAccessLayer.ProductUpdate(Me)
            Else
                dataAccessLayer.ProductInsert(Me)
            End If
        End Sub

        ''' <summary>
        ''' Initializes Product
        ''' </summary>
        ''' <param name="name">Product Name</param>
        ''' <param name="price">Product Price</param>
        ''' <param name="description">Product Description</param>
        Public Sub New(ByVal name As String, ByVal price As Decimal, ByVal description As String)
            Me.New(0, name, price, description)
        End Sub


        ''' <summary>
        ''' Initializes Product
        ''' </summary>
        ''' <param name="id">Product Id</param>
        ''' <param name="name">Product Name</param>
        ''' <param name="price">Product Price</param>
        ''' <param name="description">Product Description</param>
        Public Sub New(ByVal id As Integer, ByVal name As String, ByVal price As Decimal, ByVal description As String)
            _id = id
            _name = name
            _price = price
            _description = description
        End Sub


    End Class
end namespace
