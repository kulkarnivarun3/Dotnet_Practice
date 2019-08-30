Imports System
Imports System.Collections.Generic
Imports System.IO
Imports System.Web
Imports System.Web.Caching

Namespace AspNetUnleashed

    Public Class AutoSiteMapProvider
        Inherits StaticSiteMapProvider

        Private _rootNode As SiteMapNode
        Private Shared _excluded As New List(Of String)()
        Private _dependencies As New List(Of String)()

        ''' <summary>
        ''' These folder and pages won't be added
        ''' to the Site Map
        ''' </summary>
        Shared Sub New()
            _excluded.Add("app_code")
            _excluded.Add("app_data")
            _excluded.Add("app_themes")
            _excluded.Add("bin")
        End Sub

        ''' <summary>
        ''' Return the root node of the Site Map
        ''' </summary>
        Protected Overrides Function GetRootNodeCore() As SiteMapNode
            Return BuildSiteMap()
        End Function

        ''' <summary>
        ''' Where all of the work of building the Site Map happens
        ''' </summary>
        Public Overrides Function BuildSiteMap() As SiteMapNode
            ' Only allow the Site Map to be created by a single thread
            SyncLock Me
                ' Attempt to get Root Node from Cache
                Dim context As HttpContext = HttpContext.Current
                _rootNode = CType(context.Cache("RootNode"), SiteMapNode)
                If _rootNode Is Nothing Then
                    ' Clear current Site Map
                    Clear()

                    ' Create root node
                    Dim folderUrl As String = HttpRuntime.AppDomainAppVirtualPath
                    Dim defaultUrl As String = folderUrl + "/Default.aspx"
                    _rootNode = New SiteMapNode(Me, folderUrl, defaultUrl, "Home")
                    AddNode(_rootNode)

                    ' Create child nodes
                    AddChildNodes(_rootNode)
                    _dependencies.Add(HttpRuntime.AppDomainAppPath)

                    ' Add root node to cache with file dependencies
                    Dim fileDependency As CacheDependency = New CacheDependency(_dependencies.ToArray())
                    context.Cache.Insert("RootNode", _rootNode, fileDependency)
                End If
                Return _rootNode
            End SyncLock
        End Function

        ''' <summary>
        ''' Add child folders and pages to the Site Map
        ''' </summary>
        Private Sub AddChildNodes(ByVal parentNode As SiteMapNode)
            AddChildFolders(parentNode)
            AddChildPages(parentNode)
        End Sub

        ''' <summary>
        ''' Add child folders to the Site Map
        ''' </summary>
        Private Sub AddChildFolders(ByVal parentNode As SiteMapNode)
            Dim context As HttpContext = HttpContext.Current
            Dim parentFolderPath As String = context.Server.MapPath(parentNode.Key)
            Dim folderInfo As DirectoryInfo = New DirectoryInfo(parentFolderPath)

            ' Get sub folders
            Dim folders() As DirectoryInfo = folderInfo.GetDirectories()
            For Each folder As DirectoryInfo In folders
                If Not _excluded.Contains(folder.Name.ToLower()) Then
                    Dim folderUrl As String = parentNode.Key + "/" + folder.Name
                    Dim folderNode As SiteMapNode = New SiteMapNode(Me, folderUrl, Nothing, GetName(folder.Name))
                    AddNode(folderNode, parentNode)
                    AddChildNodes(folderNode)
                    _dependencies.Add(folder.FullName)
                End If
            Next
        End Sub

        ''' <summary>
        ''' Add child pages to the Site Map
        ''' </summary>
        Private Sub AddChildPages(ByVal parentNode As SiteMapNode)
            Dim context As HttpContext = HttpContext.Current
            Dim parentFolderPath As String = context.Server.MapPath(parentNode.Key)
            Dim folderInfo As DirectoryInfo = New DirectoryInfo(parentFolderPath)

            Dim pages() As FileInfo = folderInfo.GetFiles("*.aspx")
            For Each page As FileInfo In pages
                If Not _excluded.Contains(page.Name.ToLower()) Then
                    Dim pageUrl As String = parentNode.Key + "/" + page.Name
                    If String.Compare(pageUrl, _rootNode.Url, True) <> 0 Then
                        Dim pageNode As SiteMapNode = New SiteMapNode(Me, pageUrl, pageUrl, GetName(page.Name))
                        AddNode(pageNode, parentNode)
                    End If
                End If
            Next
        End Sub

        ''' <summary>
        ''' Fix the name of the page or folder
        ''' by removing the extension and replacing
        ''' underscores with spaces
        ''' </summary>
        Private Function GetName(ByVal name As String) As String
            name = Path.GetFileNameWithoutExtension(name)
            Return Name.Replace("_", " ")
        End Function

    End Class
End Namespace

