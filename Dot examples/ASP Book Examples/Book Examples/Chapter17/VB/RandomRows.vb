Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.SqlServer.Server

Public Class RandomRows
    <SqlProcedure()> _
    Public Shared Sub GetRandomRow()
        ' Dump all records from Movies into a DataTable
        Dim dad As New SqlDataAdapter("SELECT Id,Title FROM Movies", "context connection=true")
        Dim dtblMovies As New DataTable()
        dad.Fill(dtblMovies)

        ' Grab a random row
        Dim rnd As New Random()
        Dim ranRow As DataRow = dtblMovies.Rows(rnd.Next(dtblMovies.Rows.Count))

        ' Build a SqlDataRecord that represents the row
        Dim result As New SqlDataRecord( _
                 New SqlMetaData("Id", SqlDbType.Int), _
                 New SqlMetaData("Title", SqlDbType.NVarChar, 100))
        result.SetSqlInt32(0, CType(ranRow("Id"), Integer))
        result.SetSqlString(1, CType(ranRow("Title"), String))

        ' Send result
        SqlContext.Pipe.Send(result)
    End Sub

    <SqlProcedure> _ 
    Public Shared Sub GetRandomRows(ByVal rowsToReturn As Integer)
        ' Dump all records from Movies into a DataTable
        Dim dad As New SqlDataAdapter("SELECT Id,Title FROM Movies", "context connection=true")
        Dim dtblMovies As New DataTable()
        dad.Fill(dtblMovies)

        ' Send start record
        Dim result As New SqlDataRecord( _
              New SqlMetaData("Id", SqlDbType.Int), _ 
              New SqlMetaData("Title", SqlDbType.NVarChar, 100))
        SqlContext.Pipe.SendResultsStart(result)

        Dim rnd As Random = New Random()
        For  i As integer = 0 To rowsToReturn - 1
            ' Grab a random row
            Dim ranRow As DataRow = dtblMovies.Rows(rnd.Next(dtblMovies.Rows.Count))

            ' Set the record
            result.SetSqlInt32(0, CType(ranRow("Id"), Integer))
            result.SetSqlString(1, CType(ranRow("Title"), String))

            ' Send record
            SqlContext.Pipe.SendResultsRow(result)
        Next

        ' Send end record
        SqlContext.Pipe.SendResultsEnd()
    End Sub
End Class

