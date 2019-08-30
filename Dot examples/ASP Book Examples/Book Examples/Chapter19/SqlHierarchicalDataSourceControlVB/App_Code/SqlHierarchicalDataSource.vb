Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls

Namespace AspNetUnleashed

    ''' <summary>
    ''' Extends SqlDataSource control to support hierarchical database data
    ''' </summary>
    Public Class SqlHierarchicalDataSource
        Inherits SqlDataSource
        Implements IHierarchicalDataSource

        Private _dataKeyName As String
        Private _dataParentKeyName As String

        Public Event DataSourceChanged As EventHandler Implements IHierarchicalDataSource.DataSourceChanged

        ''' <summary>
        ''' The database table primary key
        ''' </summary>
        Public Property DataKeyName() As String
            Get
                Return _dataKeyName
            End Get
            Set(ByVal Value As String)
                _dataKeyName = Value
            End Set
        End Property

        ''' <summary>
        ''' The database table parent id
        ''' </summary>
        Public Property DataParentKeyName() As String
            Get
                Return _dataParentKeyName
            End Get
            Set(ByVal Value As String)
                _dataParentKeyName = Value
            End Set
        End Property

        ''' <summary>
        ''' Return hierarchical data
        ''' </summary>
        Public Function GetHierarchicalView(ByVal viewPath As String) As HierarchicalDataSourceView _
        Implements IHierarchicalDataSource.GetHierarchicalView
            Return New SqlHierarchicalDataSourceView(Me, viewPath)
        End Function

    End Class
End Namespace

