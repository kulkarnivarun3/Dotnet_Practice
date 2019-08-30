Imports System
Imports System.Web.UI
Imports System.Collections

Namespace AspNetUnleashed

    ''' <summary>
    ''' Represents a collection of SqlNodes
    ''' </summary>
    Public Class SqlHierarchicalEnumerable
        Inherits ArrayList
        Implements IHierarchicalEnumerable

        Public Sub New()
            MyBase.New()
        End Sub

        Public Function GetHierarchyData(ByVal EnumeratedItem As Object) As IHierarchyData _
        Implements IHierarchicalEnumerable.GetHierarchyData
            Return CType(EnumeratedItem, IHierarchyData)
        End Function

    End Class
End Namespace

