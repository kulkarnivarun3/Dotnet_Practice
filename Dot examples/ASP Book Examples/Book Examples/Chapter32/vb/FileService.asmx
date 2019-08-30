<%@ WebService Language="VB" Class="FileService" %>

Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.IO
Imports System.Linq

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<System.Web.Script.Services.ScriptService()> _
Public Class FileService
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetSuggestions(ByVal prefixText As String, ByVal count As Integer) As String()
        Dim dir As New DirectoryInfo("c:\windows")
        Return dir _
            .GetFiles() _
            .Where(Function(f) f.Name.StartsWith(prefixText)) _
            .Select(Function(f) f.Name) _
            .ToArray()
    End Function
    
End Class

