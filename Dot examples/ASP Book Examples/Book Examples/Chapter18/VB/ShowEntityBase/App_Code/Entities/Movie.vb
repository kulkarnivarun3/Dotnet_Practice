imports System

Partial Public Class Movie
    Inherits EntityBase(Of Movie)

    Protected Overrides Sub Validate()
        ' Title is required
        If Not ValidationUtility.SatisfiesRequired(Title) Then
            ValidationErrors.Add("Title", "Required")
        End If

        ' Director is required
        If Not ValidationUtility.SatisfiesRequired(Director) Then
            ValidationErrors.Add("Director", "Required")
        End If

        ' DateReleased is required
        If DateReleased = DateTime.MinValue Then
            ValidationErrors.Add("DateReleased", "Required")
        End If

        ' DateReleased can't be more than 10 years ago
        If (DateTime.Now.Year - DateReleased.Year) > 10 Then
            ValidationErrors.AddIfNotAlready("DateReleased", "Movie too old")
        End If

    End Sub

End Class
