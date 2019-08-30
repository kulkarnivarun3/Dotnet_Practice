Imports System
Imports System.Web.Compilation
Imports System.CodeDom
Imports System.IO

Namespace AspNetUnleashed
    Public Class SimpleBuildProvider
        Inherits BuildProvider

        Public Overrides Sub GenerateCode(ByVal ab As AssemblyBuilder)
            Dim fileName As String = Path.GetFileNameWithoutExtension(Me.VirtualPath)
            Dim snippet As String = "Public Class " & fileName & vbNewLine
            snippet &= "  Public Shared Sub DoSomething()" & vbNewLine
            snippet &= "  End Sub" & vbNewLine
            snippet &= "End Class"
            ab.AddCodeCompileUnit(Me, New CodeSnippetCompileUnit(snippet))
        End Sub

    End Class
End Namespace

