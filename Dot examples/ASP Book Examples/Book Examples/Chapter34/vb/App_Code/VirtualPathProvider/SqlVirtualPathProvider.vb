Imports System
Imports System.Web
Imports System.Web.Caching
Imports System.Collections
Imports System.Collections.Generic
Imports System.Web.Hosting

Namespace Superexpert

    Public Class SqlVirtualPathProvider
     Inherits VirtualPathProvider
        '/ <summary>
        '/ Register VirtualPathProvider for the application
        '/ </summary>
        Public Shared Sub AppInitialize()
            Dim sqlProvider As SqlVirtualPathProvider = New SqlVirtualPathProvider()
            HostingEnvironment.RegisterVirtualPathProvider(sqlProvider)
        End Sub


        Public Sub New()
         MyBase.New()
        End Sub

        '/ <summary>
        '/ Returns true when the file is a virtual file
        '/ instead of a normal filesystem file
        '/ </summary>
        Private Function IsVirtualFile(ByVal virtualPath As String) As Boolean
            Dim appVirtualPath As String = VirtualPathUtility.ToAppRelative(virtualPath)
            Return appVirtualPath.StartsWith("~/virtual/", StringComparison.InvariantCultureIgnoreCase)
        End Function

        '/ <summary>
        '/ Returns true when a file exists
        '/ </summary>
        Public Overrides Function FileExists(ByVal virtualPath As String) As Boolean
            If IsVirtualFile(virtualPath) Then
                Return VirtualFiles.FileExists(virtualPath)
            Else
                Return Previous.FileExists(virtualPath)
            End If
        End Function

        '/ <summary>
        '/ Gets a SqlVirtualFile which corresponds
        '/ to a file with a certain path
        '/ </summary>
        Public Overrides Function GetFile(ByVal virtualPath As String) As VirtualFile
            If IsVirtualFile(virtualPath) Then
                Return New SqlVirtualFile(virtualPath)
            Else
                Return Previous.GetFile(virtualPath)
            End If
        End Function

        '/ <summary>
        '/ Returns true when a directory exists
        '/ </summary>
        Public Overrides Function DirectoryExists(ByVal virtualPath As String) As Boolean
            If IsVirtualFile(virtualPath) Then
                Return VirtualFiles.DirectoryExists(virtualPath)
            Else
                Return Previous.DirectoryExists(virtualPath)
            End If
        End Function

        '/ <summary>
        '/ Returns a SqlVirtualDirectory which corresponds
        '/ to a virtual path
        '/ </summary>
        Public Overrides Function GetDirectory(ByVal virtualPath As String) As VirtualDirectory
            If IsVirtualFile(virtualPath) Then
                Return New SqlVirtualDirectory(virtualPath)
            Else
                Return Previous.GetDirectory(virtualPath)
            End If
        End Function

        '/ <summary>
        '/ Gets the SqlCacheDependency object for the VirtualFilesDB
        '/ database
        '/ </summary>
        Public Overrides Function GetCacheDependency(ByVal virtualPath As String, ByVal virtualPathDependencies As IEnumerable, ByVal utcStart As DateTime) As CacheDependency
            If IsVirtualFile(virtualPath) Then
                Return New SqlCacheDependency("VirtualFiles", "CodeSample")
            Else
                Return Previous.GetCacheDependency(virtualPath, virtualPathDependencies, utcStart)
            End If
        End Function

    End Class
End Namespace

