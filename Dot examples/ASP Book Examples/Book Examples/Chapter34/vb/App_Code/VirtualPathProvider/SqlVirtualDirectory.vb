Imports System
Imports System.Collections
Imports System.Web.Hosting
Imports System.Web

Namespace Superexpert

    Public Class SqlVirtualDirectory
     Inherits VirtualDirectory

        Public Sub New(ByVal virtualPath As String)
            MyBase.New(virtualPath)
        End Sub


        Public ReadOnly Property AppPath() As String
            Get
                 Return VirtualPathUtility.ToAppRelative(VirtualPath)
            End Get
        End Property


        Public Overrides ReadOnly Property Children() As IEnumerable
            Get
                 Return VirtualFiles.DirectorySelectChildren(VirtualPath)
            End Get
        End Property



        Public Overrides ReadOnly Property Directories() As IEnumerable
            Get
                 Return VirtualFiles.DirectorySelectDirectories(VirtualPath)
            End Get
        End Property

        Public Overrides ReadOnly Property Files() As IEnumerable
            Get
                 Return VirtualFiles.DirectorySelectFiles(VirtualPath)
            End Get
        End Property
    End Class
End Namespace

