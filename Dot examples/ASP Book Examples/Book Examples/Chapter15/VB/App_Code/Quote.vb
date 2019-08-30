Imports System.Collections.Generic

Public Class Quote

    Private _quotes As New List(Of String)

    Public Function GetQuote() As String
        Dim rnd As New Random()
        Return _quotes(rnd.Next(_quotes.Count))
    End Function

    Public Sub New()
        _quotes.Add("All paid jobs absorb and degrade the mind -- Aristotle")
        _quotes.Add("No evil can happen to a good man, either in life or after death -- Plato")
        _quotes.Add("The only good is knowledge and the only evil is ignorance -- Plato")
    End Sub

End Class
