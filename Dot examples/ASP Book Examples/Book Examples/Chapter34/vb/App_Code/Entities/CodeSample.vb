Imports System
Imports System.Linq
Imports System.Data.Linq.Mapping
Imports System.Collections.Generic
Imports System.Web

''' <summary>
''' Summary description for Entry
''' </summary>
Partial Public Class CodeSample
     Inherits EntityBase(Of CodeSample)

    Public Shared Function SelectByEnTryId(ByVal entryId As Integer) As IEnumerable(Of CodeSample)
        Return Table.Where(Function(s) s.EntryId = entryId)
    End Function

    Protected Overrides Sub Validate()
        ' Security check
        If Not ValidationUtility.IsInRole("Administrators") Then
            Dim userName As String = HttpContext.Current.User.Identity.Name
            Dim entry As Entry = entry.Table.Where(Function(e) e.Id = EntryId And e.AuthorUserName = userName).SingleOrDefault()
            If entry Is Nothing Then
                ValidationErrors.Add("AuthorUserName", "Only the original author or an administrator can modify this code sample")
            End If
        End If


        If Not ValidationUtility.SatisfiesRequired(FileName) Then
            ValidationErrors.Add("FileName", "File Name is required", "required")
        End If

        If LanguageId = -1 Then
            ValidationErrors.Add("LanguageId", "Select a language")
        End If

        If Not ValidationUtility.SatisfiesRequired(Description) Then
            ValidationErrors.Add("Description", "Description is required", "required")
        End If

        If Not ValidationUtility.SatisfiesRequired(Code) Then
            ValidationErrors.Add("Code", "Code is required", "required")
        End If


    End Sub


    Private Sub OnCreated()
        Me.LanguageId = -1
    End Sub


End Class

