Imports System
Imports System.Text
Imports Microsoft.SqlServer.Server
Imports System.Data.SqlTypes
Imports System.Runtime.InteropServices
Imports System.IO

<SqlUserDefinedType(Format.UserDefined, MaxByteSize:=512, IsByteOrdered:=True)> _
Public Class DBMovie
    Implements INullable
    Implements IBinarySerialize

    Private _isNull As Boolean
    Private _title As String
    Private _director As String
    Private _boxOfficeTotals As Decimal

    Public ReadOnly Property IsNull() As Boolean Implements INullable.IsNull
        Get
            Return _isNull
        End Get
    End Property

    Public Shared ReadOnly Property Null() As DBMovie
        Get
            Dim movie As New DBMovie()
            movie._isNull = True
            Return movie
        End Get
    End Property

    Public Property Title() As String
        Get
            Return _title
        End Get
        Set(ByVal Value As String)
            _title = Value
        End Set
    End Property


    Public Property Director() As String
        Get
            Return _director
        End Get
        Set(ByVal Value As String)
            _director = Value
        End Set
    End Property

    <SqlFacet(Precision:=38, Scale:=2)> _
    Public Property BoxOfficeTotals() As Decimal
        Get
            Return _boxOfficeTotals
        End Get
        Set(ByVal Value As Decimal)
            _boxOfficeTotals = Value
        End Set
    End Property


    <SqlMethod(OnNullCall:=False)> _
    Public Shared Function Parse(ByVal s As SqlString) As DBMovie
        If (s.IsNull) Then
            Return Null
        End If
        Dim movie As New DBMovie()
        Dim parts() As String = s.Value.Split(New Char() {","c})
        movie.Title = parts(0)
        movie.Director = parts(1)
        movie.BoxOfficeTotals = Decimal.Parse(parts(2))
        Return movie
    End Function

    Public Overrides Function ToString() As String
        If Me.IsNull Then
            Return "NULL"
        End If
        Dim builder As New StringBuilder()
        builder.Append(_title)
        builder.Append(",")
        builder.Append(_director)
        builder.Append(",")
        builder.Append(_boxOfficeTotals.ToString())
        Return builder.ToString()
    End Function

    Public Sub Write(ByVal w As BinaryWriter) Implements IBinarySerialize.Write
        w.Write(_title)
        w.Write(_director)
        w.Write(_boxOfficeTotals)
    End Sub

    Public Sub Read(ByVal r As BinaryReader) Implements IBinarySerialize.Read
        _title = r.ReadString()
        _director = r.ReadString()
        _boxOfficeTotals = r.ReadDecimal()
    End Sub

    Public Sub New()
    End Sub
End Class

