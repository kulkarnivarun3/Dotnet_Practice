Public Class ServerTime

    Public ReadOnly Property CurrentTime() As String
        Get
            Return DateTime.Now.ToString()
        End Get
    End Property

End Class
