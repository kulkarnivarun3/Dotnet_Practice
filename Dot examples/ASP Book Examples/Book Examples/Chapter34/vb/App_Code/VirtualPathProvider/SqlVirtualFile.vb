Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Hosting
Imports System.IO
Imports System.Web

Namespace Superexpert

    '/ <summary>
    '/ Summary description for SqlVirtualFile
    '/ </summary>
    Public Class SqlVirtualFile
     Inherits VirtualFile

        Public Sub New(ByVal virtualPath As String)
            MyBase.New(virtualPath)
        End Sub


        Public Overrides Function Open() As Stream
            ' Get content from database
            Dim content As String = VirtualFiles.FileContentSelect(Me.VirtualPath)

            ' return results as stream
            Dim mem As MemoryStream = New MemoryStream()
            Dim writer As StreamWriter = New StreamWriter(mem)
            writer.Write(content)
            writer.Flush()
            mem.Seek(0, SeekOrigin.Begin)
            Return mem
        End Function

        Public ReadOnly Property Content() As String
            Get
                Return VirtualFiles.FileContentSelect(Me.VirtualPath)
            End Get
        End Property


    End Class
End Namespace

