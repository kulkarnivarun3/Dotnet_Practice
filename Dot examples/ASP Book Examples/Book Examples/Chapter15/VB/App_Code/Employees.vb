
Public MustInherit Class BaseEmployee

    Public MustOverride ReadOnly Property Salary() As Decimal

    Public ReadOnly Property Company() As String
        Get
            Return "Acme Software"
        End Get
    End Property

End Class

Public Class SalesEmployee
    Inherits BaseEmployee

    Public Overrides ReadOnly Property Salary() As Decimal
        Get
            Return 67000.23D
        End Get
    End Property

End Class

