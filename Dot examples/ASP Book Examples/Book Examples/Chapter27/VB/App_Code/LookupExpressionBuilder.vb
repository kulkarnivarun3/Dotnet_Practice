Imports System
Imports System.CodeDom
Imports System.Web.UI
Imports System.ComponentModel
Imports System.Web.Compilation
Imports System.Xml
Imports System.Web.Hosting
Imports System.Web.Caching

Namespace AspNetUnleashed
    Public Class LookupExpressionBuilder
        Inherits ExpressionBuilder

        Public Overrides Function GetCodeExpression(ByVal enTry As BoundPropertyEntry, ByVal parsedData As Object, ByVal context As ExpressionBuilderContext) As CodeExpression
            Dim refMe As New CodeTypeReferenceExpression(MyBase.GetType())
            Dim expression As New CodePrimitiveExpression(enTry.Expression)
            Return New CodeMethodInvokeExpression(refMe, "GetEvalData", New CodeExpression() {expression})
        End Function

        Public Overrides Function EvaluateExpression(ByVal target As Object, ByVal enTry As BoundPropertyEnTry, ByVal parsedData As Object, ByVal context As ExpressionBuilderContext) As Object
            Return GetEvalData(enTry.Expression)
        End Function

        Public Overrides ReadOnly Property SupportsEvaluate() As Boolean
            Get
                Return True
            End Get
        End Property

        Public Shared Function GetEvalData(ByVal expression As String) As String
            Dim lookupDoc As XmlDocument = CType(HostingEnvironment.Cache("Lookup"), XmlDocument)
            If IsNothing(lookupDoc) Then
                lookupDoc = New XmlDocument()
                Dim lookupFileName As String = HostingEnvironment.MapPath("~/Lookup.config")
                lookupDoc.Load(lookupFileName)
                Dim fileDepend As New CacheDependency(lookupFileName)
                HostingEnvironment.Cache.Insert("Lookup", lookupDoc, fileDepend)
            End If

            Dim search As String = String.Format("//add[@key='{0}']", expression)
            Dim match As XmlNode = lookupDoc.SelectSingleNode(search)
            If Not IsNothing(match) Then
                Return match.Attributes("value").Value
            End If
            Return "[no match]"
        End Function

    End Class
End Namespace

