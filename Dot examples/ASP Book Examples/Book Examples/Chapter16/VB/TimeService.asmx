<%@ WebService Language="VB" Class="TimeService" %>
Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
 
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
Public Class TimeService
    Inherits System.Web.Services.WebService
 
    <WebMethod()> _
    Public Function GetServerTime() As DateTime
        Return DateTime.Now
    End Function
 
End Class

