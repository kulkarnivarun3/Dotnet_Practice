Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Collections.Generic
Imports AcmeStore.BusinessLogicLayer

Namespace AcmeStore.DataAccessLayer

    ''' <summary>
    ''' Data Access Layer for interacting with Microsoft
    ''' SQL Server 2005
    ''' </summary>
    Public Class SqlDataAccessLayer
        Private Shared ReadOnly _connectionString As String = String.Empty

        ''' <summary>
        ''' Selects all products from the database
        ''' </summary>
        Public Function ProductSelectAll() As List(Of Product)
            ' Create Product collection
            Dim colProducts As New List(Of Product)()

            ' Create connection
            Dim con As SqlConnection = New SqlConnection(_connectionString)

            ' Create command
            Dim cmd As SqlCommand = New SqlCommand()
            cmd.Connection = con
            cmd.CommandText = "SELECT Id,Name,Price,Description FROM Products"

            ' Execute command
            Using con
                con.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                While reader.Read()
                    colProducts.Add(New Product( _
                        CType(reader("Id"), Integer), _
                        CType(reader("Name"), String), _
                        CType(reader("Price"), Decimal), _
                        CType(reader("Description"), String)))
                End While
            End Using
            Return colProducts
        End Function

        ''' <summary>
        ''' Inserts a new product into the database
        ''' </summary>
        ''' <param name="newProduct">Product</param>
        Public Sub ProductInsert(ByVal NewProduct As Product)
            ' Create connection
            Dim con As SqlConnection = New SqlConnection(_connectionString)

            ' Create command
            Dim cmd As SqlCommand = New SqlCommand()
            cmd.Connection = con
            cmd.CommandText = "INSERT Products (Name,Price,Description) VALUES (@Name,@Price,@Description)"

            ' Add parameters
            cmd.Parameters.AddWithValue("@Name", NewProduct.Name)
            cmd.Parameters.AddWithValue("@Price", NewProduct.Price)
            cmd.Parameters.AddWithValue("@Description", NewProduct.Description)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub

        ''' <summary>
        ''' Updates an existing product into the database
        ''' </summary>
        ''' <param name="productToUpdate">Product</param>
        Public Sub ProductUpdate(ByVal productToUpdate As Product)
            ' Create connection
            Dim con As SqlConnection = New SqlConnection(_connectionString)

            ' Create command
            Dim cmd As SqlCommand = New SqlCommand()
            cmd.Connection = con
            cmd.CommandText = "UPDATE Products SET Name=@Name,Price=@Price,Description=@Description WHERE Id=@Id"

            ' Add parameters
            cmd.Parameters.AddWithValue("@Name", productToUpdate.Name)
            cmd.Parameters.AddWithValue("@Price", productToUpdate.Price)
            cmd.Parameters.AddWithValue("@Description", productToUpdate.Description)
            cmd.Parameters.AddWithValue("@Id", productToUpdate.Id)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub

        ''' <summary>
        ''' Deletes an existing product in the database
        ''' </summary>
        ''' <param name="id">Product Id</param>
        Public Sub ProductDelete(ByVal Id As Integer)
            ' Create connection
            Dim con As SqlConnection = New SqlConnection(_connectionString)

            ' Create command
            Dim cmd As SqlCommand = New SqlCommand()
            cmd.Connection = con
            cmd.CommandText = "DELETE Products WHERE Id=@Id"

            ' Add parameters
            cmd.Parameters.AddWithValue("@Id", Id)

            ' Execute command
            Using con
                con.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Sub

        ''' <summary>
        ''' Initialize the data access layer by
        ''' loading the database connection string from 
        ''' the Web.Config file
        ''' </summary>
        Shared Sub New()
            _connectionString = WebConfigurationManager.ConnectionStrings("Store").ConnectionString
            If String.IsNullOrEmpty(_connectionString) Then
                Throw New Exception("No connection String configured in Web.Config file")
            End If
        End Sub
    End Class
End Namespace
