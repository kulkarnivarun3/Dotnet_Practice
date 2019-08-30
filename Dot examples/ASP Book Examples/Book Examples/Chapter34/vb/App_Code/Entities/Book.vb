Imports System
Imports System.Data.Linq.Mapping

''' <summary>
''' Summary description for Book
''' </summary>
Partial Public Class Book
     Inherits EntityBase(Of Book)

    Protected Overrides Sub Validate()

        If Not ValidationUtility.SatisfiesRequired(Title) Then
            ValidationErrors.Add("Title", "Title is required", "required")
        End If
        If Not ValidationUtility.SatisfiesRequired(Authors) Then
            ValidationErrors.Add("Authors", "Authors is required", "required")
        End If
        If Not ValidationUtility.SatisfiesRequired(Description) Then
            ValidationErrors.Add("Description", "Description is required", "required")
        End If
        If Not ValidationUtility.SatisfiesType(BuyLink, "url") Then
            ValidationErrors.Add("BuyLink", "Buy link is invalid URL", "invalid")
        End If

    End Sub



End Class

