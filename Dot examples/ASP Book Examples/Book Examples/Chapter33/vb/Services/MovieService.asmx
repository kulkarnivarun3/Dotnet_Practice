<%@ WebService Language="vb" Class="MovieService" %>

Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Collections.Generic
Imports System.Linq
Imports System.Data.Linq
Imports System.Web.Script.Services

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ScriptService()> _
Public Class MovieService
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function SelectAll() As List(Of Movie)
        Dim db As New MyDatabaseDataContext()
        Return db.Movies.ToList()
    End Function

    <WebMethod()> _
    Public Function Insert(ByVal movieToAdd As Movie) As Integer
        Dim db = New MyDatabaseDataContext()
        db.Movies.InsertOnSubmit(movieToAdd)
        db.SubmitChanges()
        Return movieToAdd.Id
    End Function

   
End Class

