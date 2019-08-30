Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Data.Linq
Imports System.Linq.Expressions
Imports System.Reflection

Partial Public Class Movie



    Public Shared Function [Select](ByVal orderBy As String) As IEnumerable(Of Movie)
        Dim orderByColumn As String = "Id"
        Dim orderByDirection As String = "asc"
        If Not String.IsNullOrEmpty(orderBy) Then
            ParseOrderBy(orderBy, orderByColumn, orderByDirection)
        End If

        Dim db As New MyDatabaseDataContext()
        If (orderByDirection = "asc") Then
            Return db.Movies.OrderBy(GetDynamicSort(orderByColumn))
        Else
            Return db.Movies.OrderByDescending(GetDynamicSort(orderByColumn))
            End If
    End Function



    Public Shared Sub ParseOrderBy(ByVal orderBy As String, ByRef orderByColumn As String, ByRef orderByDirection As String)
        Dim orderByParts As String() = orderBy.Split(" ")
        orderByColumn = orderByParts(0)
        If orderByParts.Length > 1 Then
            orderByDirection = orderByParts(1).ToLower()
        End If
    End Sub


    Private Shared Function GetDynamicSort(ByVal orderByColumn As String) As Expression(Of Func(Of Movie, String))
        ' Create expression to represent Movie parameter into lambda expression
        Dim pMovie As ParameterExpression = Expression.Parameter(GetType(Movie), "m")

        ' Create expression to access value of order by column 
        Dim propInfo As PropertyInfo = GetType(Movie).GetProperty(orderByColumn)
        Dim m As MemberExpression = Expression.MakeMemberAccess(pMovie, propInfo)

        ' Box it
        Dim b As UnaryExpression = Expression.TypeAs(m, GetType(Object))

        ' Convert to string
        Dim convertMethod As MethodInfo = GetType(Convert).GetMethod("ToString", _
            New Type() {GetType(Object)})
        Dim c As MethodCallExpression = Expression.Call(Nothing, convertMethod, b)

        ' Return lambda
        Return Expression.Lambda(Of Func(Of Movie, String))(c, pMovie)
    End Function




    Public Shared Sub Delete(ByVal movieToDelete As Movie)
        Dim db As New MyDatabaseDataContext()
        db.Movies.Attach(movieToDelete)
        db.Movies.DeleteOnSubmit(movieToDelete)
        db.SubmitChanges()
    End Sub



    Public Shared Sub Update(ByVal oldMovie As Movie, ByVal newMovie As Movie)
        Dim db As New MyDatabaseDataContext()
        db.Movies.Attach(newMovie, oldMovie)
        db.SubmitChanges()
    End Sub


    Public Shared Function Insert(ByVal movieToInsert As Movie) As Integer
        Dim db As New MyDatabaseDataContext()
        db.Movies.InsertOnSubmit(movieToInsert)
        db.SubmitChanges()
        Return movieToInsert.Id
    End Function



    Public Shared Function SelectCached() As IEnumerable(Of Movie)
        Dim context As HttpContext = HttpContext.Current
        Dim movies As List(Of Movie) = CType(context.Cache("Movies"), List(Of Movie))
        If movies Is Nothing Then
            movies = [Select]().ToList()
            context.Cache("Movies") = movies
            context.Trace.Warn("Retrieving movies from database")
        End If
        Return movies
    End Function



    Public Shared Function [Select]() As IEnumerable(Of Movie)
        Dim db As New MyDatabaseDataContext()
        Return db.Movies
    End Function

    Public Shared Function SelectPaged(ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As IEnumerable(Of Movie)
        Return [Select]().Skip(startRowIndex).Take(maximumRows)
    End Function

    Public Shared Function SelectCount() As Integer
        Return [Select]().Count()
    End Function

End Class
