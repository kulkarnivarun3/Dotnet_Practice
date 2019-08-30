Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Data.SqlClient

Namespace AspNetUnleashed

    ''' <summary>
    ''' Represents the data returned from database
    ''' </summary>
    Public Class SqlHierarchicalDataSourceView
        Inherits HierarchicalDataSourceView

        Private _owner As SqlHierarchicalDataSource
        Private _viewPath As String
        Private _data As DataTable

        Public Sub New(ByVal owner As SqlHierarchicalDataSource, ByVal viewPath As String)
            _owner = owner
            _viewPath = viewPath
        End Sub

        ''' <summary>
        ''' The DataTable which contains all rows from
        ''' underlying database table
        ''' </summary>
        Public ReadOnly Property Data() As DataTable
            Get
                Return _data
            End Get
        End Property

        ''' <summary>
        ''' We need to expose this for the SqlNodes
        ''' </summary>
        Public ReadOnly Property DataKeyName() As String
            Get
                Return _owner.DataKeyName
            End Get
        End Property

        ''' <summary>
        ''' We need to expose this for the SqlNodes
        ''' </summary>
        Public ReadOnly Property DataParentKeyName() As String
            Get
                Return _owner.DataParentKeyName
            End Get
        End Property

        ''' <summary>
        ''' Get the top-level rows (rows without parent rows)
        ''' </summary>
        Public Overrides Function [Select]() As IHierarchicalEnumerable
            ' Verify DataKeyName and DataParentKeyName properties
            If String.IsNullOrEmpty(DataKeyName) Then
                Throw New Exception("You must set the DataKeyName property")
            End If
            If String.IsNullOrEmpty(DataParentKeyName) Then
                Throw New Exception("You must set the DataParentKeyName property")
            End If

            ' Return DataView from SqlDataSource 
            If _owner.DataSourceMode <> SqlDataSourceMode.DataSet Then
                Throw New Exception("DataSourceMode must be set to DataSet")
            End If
            Dim view As DataView = CType(_owner.Select(DataSourceSelectArguments.Empty), DataView)
            _data = view.Table

            ' Get the root rows
            Dim filter As String = String.Format("{0} IS NULL", Me.DataParentKeyName)
            Dim rootRows() As DataRow = _data.Select(filter)

            ' Build up the hierarchical collection
            Dim en As SqlHierarchicalEnumerable = New SqlHierarchicalEnumerable()
            For Each row As DataRow In rootRows
                en.Add(New SqlNode(Me, row))
            Next
            Return en
        End Function

    End Class
End Namespace

