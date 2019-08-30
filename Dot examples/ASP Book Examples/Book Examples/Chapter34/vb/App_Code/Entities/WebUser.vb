Imports System
Imports System.Linq
Imports System.Data.Linq
Imports System.Data.Linq.Mapping

''' <summary>
''' Summary description for WebUser
''' </summary>
Partial Public Class WebUser
     Inherits EntityBase(Of WebUser)


    Public Shared Function [Get](ByVal userName As String) As WebUser
        Dim match As WebUser = Table.Where(Function(w) w.UserName = userName).SingleOrDefault()
        If match Is Nothing Then
            Return New WebUser()
        End If
        Return match
    End Function


    Public Overrides Sub Save(ByVal NewEntity As WebUser)
        NewEntity.PerformValidation()
        Dim match As WebUser = Table.Where(Function(w) w.UserName = NewEntity.UserName).SingleOrDefault()
        If match Is Nothing Then
            NewEntity.Insert()
        Else
            match.FirstName = NewEntity.FirstName
            match.LastName = NewEntity.LastName
            match.WebsiteUrl = NewEntity.WebsiteUrl
            match.Profile = NewEntity.Profile
            match.ReceiveNewsletter = NewEntity.ReceiveNewsletter
            Table.Context.SubmitChanges()
        End If
    End Sub




    Protected Overrides Sub Validate()
        If Not ValidationUtility.SatisfiesRequired(FirstName) Then
            ValidationErrors.Add("FirstName", "Required")
        End If
        If Not ValidationUtility.SatisfiesRequired(LastName) Then
            ValidationErrors.Add("LastName", "Required")
        End If
        If Not String.IsNullOrEmpty(WebsiteUrl) And Not ValidationUtility.SatisfiesType(WebsiteUrl, "url") Then
            ValidationErrors.AddIfNotAlready("WebsiteUrl", "Invalid website address")
        End If
    End Sub





End Class

