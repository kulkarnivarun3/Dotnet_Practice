Imports System
Imports System.Collections.Specialized
Imports System.Web.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports System.Web.Caching

Namespace AspNetUnleashed

    ''' <summary>
    ''' Summary description for SqlSiteMapProvider
    ''' </summary>
    Public Class SqlSiteMapProvider
        Inherits StaticSiteMapProvider

        Private _isInitialized As Boolean = False
        Private _connectionString As String
        Private _rootNode As SiteMapNode

        ''' <summary>
        ''' Initialize provider with database
        ''' connection string
        ''' </summary>
        Public Overrides Sub Initialize(ByVal name As String, ByVal attributes As NameValueCollection)
            If _isInitialized Then
                Return
            End If

            MyBase.Initialize(name, attributes)

            Dim connectionStringName As String = attributes("connectionStringName")
            If String.IsNullOrEmpty(connectionStringName) Then
                Throw New Exception("You must provide a connectionStringName attribute")
            End If

            _connectionString = WebConfigurationManager.ConnectionStrings(connectionStringName).ConnectionString
            If String.IsNullOrEmpty(_connectionString) Then
                Throw New Exception("Could not find connection String " + connectionStringName)
            End If

            _isInitialized = True
        End Sub

        ''' <summary>
        ''' Return root node by calling
        ''' BuildSiteMap
        ''' </summary>
        Protected Overrides Function GetRootNodeCore() As SiteMapNode
            Return BuildSiteMap()
        End Function

        ''' <summary>
        ''' Build the Site Map and
        ''' create SQL Cache Dependency
        ''' </summary>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Overrides Function BuildSiteMap() As SiteMapNode
            ' Only allow the Site Map to be created by a single thread
            SyncLock Me
                ' Attempt to get Root Node from Cache
                Dim context As HttpContext = HttpContext.Current
                _rootNode = CType(context.Cache("RootNode"), SiteMapNode)

                If _rootNode Is Nothing Then
                    HttpContext.Current.Trace.Warn("Loading from database")

                    ' Clear current Site Map
                    Clear()

                    ' Load the database data
                    Dim tblSiteMap As DataTable = GetSiteMapFromDB()

                    ' Get the root node
                    _rootNode = GetRootNode(tblSiteMap)
                    AddNode(_rootNode)

                    ' Build the child nodes 
                    BuildSiteMapRecurse(tblSiteMap, _rootNode)

                    ' Add root node to cache with database dependency
                    Dim sqlDepend As SqlCacheDependency = New SqlCacheDependency("SiteMapDB", "SiteMap")
                    context.Cache.Insert("RootNode", _rootNode, sqlDepend)
                End If
                Return _rootNode
            End SyncLock
        End Function

        ''' <summary>
        ''' Loads Site Map from Database
        ''' </summary>
        Private Function GetSiteMapFromDB() As DataTable
            Dim selectCommand As String = "SELECT Id,ParentId,Url,Title,Description FROM SiteMap"
            Dim dad As New SqlDataAdapter(selectCommand, _connectionString)
            Dim tblSiteMap As New DataTable()
            dad.Fill(tblSiteMap)
            Return tblSiteMap
        End Function

        ''' <summary>
        ''' Gets the root node by returning row
        ''' with null ParentId
        ''' </summary>
        Private Function GetRootNode(ByVal siteMapTable As DataTable) As SiteMapNode
            Dim results() As DataRow = siteMapTable.Select("ParentId IS NULL")
            If results.Length = 0 Then
                Throw New Exception("No root node in database")
            End If
            Dim rootRow As DataRow = results(0)
            Return New SiteMapNode(Me, rootRow("Id").ToString(), rootRow("url").ToString(), rootRow("title").ToString(), rootRow("description").ToString())
        End Function

        ''' <summary>
        ''' Recursively builds a Site Map by iterating ParentId
        ''' </summary>
        Private Sub BuildSiteMapRecurse(ByVal siteMapTable As DataTable, ByVal parentNode As SiteMapNode)
            Dim results() As DataRow = siteMapTable.Select("ParentId=" + parentNode.Key)
            For Each row As DataRow In results
                Dim node As SiteMapNode = New SiteMapNode(Me, row("Id").ToString(), row("url").ToString(), row("title").ToString(), row("description").ToString())
                AddNode(node, parentNode)
                BuildSiteMapRecurse(siteMapTable, node)
            Next
        End Sub

    End Class
End Namespace

