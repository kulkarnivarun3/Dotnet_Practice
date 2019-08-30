Imports System.Runtime.CompilerServices

Public Module MyExtensions

    <Extension()> _
    Public Function HtmlEncode(ByVal str As String) As String
        Return System.Web.HttpUtility.HtmlEncode(str)
    End Function

End Module
