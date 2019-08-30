Imports System
Imports System.ComponentModel
Imports System.Data


Namespace AspNetUnleashed

    ''' <summary>
    ''' Describes a property of a SqlNode
    ''' </summary>
    Public Class SqlNodePropertyDescriptor
        Inherits PropertyDescriptor

        Public Sub New(ByVal name As String)
            MyBase.New(name, Nothing)
        End Sub


        ''' <summary>
        ''' Return the value of a DataColumn represented by
        ''' a particular SqlNode
        ''' </summary>
        Public Overrides Function GetValue(ByVal component As Object) As Object
            Dim node As SqlNode = CType(component, SqlNode)
            Return (CType(node.Item, DataRow))(Me.Name)
        End Function


        ' Don't bother to implement any of the other methods or properties
        ' of this class

        Public Overrides Function CanResetValue(ByVal component As Object) As Boolean
            Throw New Exception("Not implemented.")
        End Function

        Public Overrides ReadOnly Property ComponentType() As Type
            Get
                Throw New Exception("Not implemented.")
            End Get
        End Property

        Public Overrides ReadOnly Property IsReadOnly() As Boolean
            Get
                Throw New Exception("Not implemented.")
            End Get
        End Property

        Public Overrides ReadOnly Property PropertyType() As Type
            Get
                Throw New Exception("Not implemented.")
            End Get
        End Property

        Public Overrides Sub ResetValue(ByVal component As Object)
            Throw New Exception("Not implemented.")
        End Sub

        Public Overrides Sub SetValue(ByVal component As Object, ByVal value As Object)
            Throw New Exception("Not implemented.")
        End Sub

        Public Overrides Function ShouldSerializeValue(ByVal component As Object) As Boolean
            Throw New Exception("Not implemented.")
        End Function
    End Class
End Namespace

