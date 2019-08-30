Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient

Public Class GenericMethods

    Public Shared Function GetListFromCommand(Of T As {ICreatable, New})(ByVal command As SqlCommand) As List(Of T)
        Dim results As New List(Of T)()
        Using command.Connection
            command.Connection.Open()
            Dim reader As SqlDataReader = command.ExecuteReader()
            While (reader.Read())
                Dim newThing As New T()
                newThing.Create(reader)
                results.Add(newThing)
            End While
        End Using
        Return results
    End Function
End Class

Public Interface ICreatable
    Sub Create(ByVal reader As SqlDataReader)
End Interface
