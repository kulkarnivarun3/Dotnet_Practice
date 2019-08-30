Public Class LocalComponent

    Public Shared Function getResource() As String
        Return CType(HttpContext.GetLocalResourceObject("~/LocalizablePage.aspx", "ClickHere"), String)
    End Function

End Class
