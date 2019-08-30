<%@ WebService Language="vb" Class="QuotationService" %>

Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Web.Script.Services
Imports System.Collections.Generic

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ScriptService()> _
Public Class QuotationService
    Inherits System.Web.Services.WebService


    <WebMethod()> _
    Public Function GetQuote() As String
        Dim quotes = New List(Of String)()
        quotes.Add("The fool who is silent passes for wise.")
        quotes.Add("The early bird catches the worm.")
        quotes.Add("If wishes were true, shepherds would be kings.")
        Dim Rnd As New Random()
        Return quotes(Rnd.Next(quotes.Count))
    End Function
    
End Class

