Imports System
Imports System.Collections.Generic
Imports System.Data
Imports System.ComponentModel
Imports System.Web.UI

Namespace AspNetUnleashed

    ''' <summary>
    ''' Represents a node (row) from the database
    ''' </summary>
    Public Class SqlNode
        Implements IHierarchyData
        Implements ICustomTypeDescriptor

        Private _owner As SqlHierarchicalDataSourceView
        Private _row As DataRow

        Public Sub New(ByVal owner As SqlHierarchicalDataSourceView, ByVal row As DataRow)
            _owner = owner
            _row = row
        End Sub

        ''' <summary>
        ''' Does the current database row have child rows?
        ''' </summary>
        Public ReadOnly Property HasChildren() As Boolean _
        Implements IHierarchyData.HasChildren
            Get
                Dim filter As String = String.Format("{0}={1}", _owner.DataParentKeyName, _row(_owner.DataKeyName))
                Dim childRows() As DataRow = _owner.Data.Select(filter)

                Return childRows.Length > 0
            End Get
        End Property


        ''' <summary>
        ''' Returns the DataRow
        ''' </summary>
        Public ReadOnly Property Item() As Object _
        Implements IHierarchyData.Item
            Get
                Return _row
            End Get
        End Property

        ''' <summary>
        ''' A unique identifier for the row
        ''' </summary>
        Public ReadOnly Property Path() As String _
        Implements IHierarchyData.Path
            Get
                Return _row(_owner.DataKeyName).ToString()
            End Get
        End Property


        ''' <summary>
        ''' The Type is used in switching logic
        ''' </summary>
        Public ReadOnly Property Type() As String _
        Implements IHierarchyData.Type
            Get
                Return "SqlNode"
            End Get
        End Property

        ''' <summary>
        ''' The ToString() method is called to show
        ''' the value of a row (we default to showing
        ''' the value of the first column)
        ''' </summary>
        Public Overrides Function ToString() As String
            Return _row(0).ToString()
        End Function

        ''' <summary>
        ''' Get child rows of current row
        ''' </summary>
        Public Function GetChildren() As IHierarchicalEnumerable _
        Implements IHierarchyData.GetChildren
            Dim filter As String = String.Format("{0}={1}", _owner.DataParentKeyName, _row(_owner.DataKeyName))
            Dim childRows() As DataRow = _owner.Data.Select(filter)

            Dim en As SqlHierarchicalEnumerable = New SqlHierarchicalEnumerable()
            For Each row As DataRow In childRows
                en.Add(New SqlNode(_owner, row))
            Next
            Return en
        End Function


        ''' <summary>
        ''' Get Parent Row of current row
        ''' </summary>
        Public Function GetParent() As IHierarchyData _
        Implements IHierarchyData.GetParent
            Dim filter As String = String.Format("{0}={1}", _owner.DataKeyName, _row(_owner.DataParentKeyName))
            Dim parentRows() As DataRow = _owner.Data.Select(filter)

            If parentRows.Length > 0 Then
                Return New SqlNode(_owner, parentRows(0))
            Else
                Return Nothing
            End If

        End Function

        ''' <summary>
        ''' Get the list of properties supported by the SqlNode
        ''' </summary>
        Public Function GetProperties() As PropertyDescriptorCollection _
        Implements ICustomTypeDescriptor.GetProperties
            Dim props As New List(Of PropertyDescriptor)()
            For Each col As DataColumn In _owner.Data.Columns
                props.Add(New SqlNodePropertyDescriptor(col.ColumnName))
            Next
            Return New PropertyDescriptorCollection(props.ToArray())
        End Function


        ' The following properties and methods are required by the
        ' ICustomTypeDescriptor interface but are not implemented

        Public Function GetAttributes() As System.ComponentModel.AttributeCollection _
        Implements ICustomTypeDescriptor.GetAttributes
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetClassName() As String _
        Implements ICustomTypeDescriptor.GetClassName
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetComponentName() As String _
        Implements ICustomTypeDescriptor.GetComponentName
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetConverter() As TypeConverter _
        Implements ICustomTypeDescriptor.GetConverter
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetDefaultEvent() As EventDescriptor _
        Implements ICustomTypeDescriptor.GetDefaultEvent
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetDefaultProperty() As PropertyDescriptor _
        Implements ICustomTypeDescriptor.GetDefaultProperty
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetEditor(ByVal editorBaseType As Type) As Object _
        Implements ICustomTypeDescriptor.GetEditor
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetEvents(ByVal attributes() As Attribute) As EventDescriptorCollection _
        Implements ICustomTypeDescriptor.GetEvents
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetEvents() As EventDescriptorCollection _
        Implements ICustomTypeDescriptor.GetEvents
            Throw New Exception("Not implemented.")
        End Function

        Public Function GetProperties(ByVal attributes() As Attribute) As PropertyDescriptorCollection _
        Implements ICustomTypeDescriptor.GetProperties
            Throw New Exception("Not implemented.")
        End Function


        Public Function GetPropertyOwner(ByVal pd As PropertyDescriptor) As Object _
        Implements ICustomTypeDescriptor.GetPropertyOwner
            Throw New Exception("Not implemented.")
        End Function

    End Class
End Namespace

