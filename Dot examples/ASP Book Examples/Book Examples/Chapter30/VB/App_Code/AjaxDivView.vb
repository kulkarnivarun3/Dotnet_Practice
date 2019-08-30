Imports System
Imports System.Text
Imports System.IO
Imports System.Collections
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace AspNetUnleashed
    Public Class AjaxDivView
        Inherits CompositeDataBoundControl
        Implements ICallbackEventHandler

        Private _itemTemplate As ITemplate

        ''' <summary>
        ''' The ItemTemplate is used to format each item
        ''' from the data source
        ''' </summary>
        <TemplateContainer(GetType(DivViewItem))> _
        <PersistenceMode(PersistenceMode.InnerProperty)> _
        Public Property ItemTemplate() As ITemplate
            Get
                Return _itemTemplate
            End Get
            Set(ByVal Value As ITemplate)
                _itemTemplate = Value
            End Set
        End Property

        ''' <summary>
        ''' Register JavaScripts
        ''' </summary>
        Protected Overrides Sub OnPreRender(ByVal e As EventArgs)
            ' Register JavaScript library
            Page.ClientScript.RegisterClientScriptInclude("AjaxDivView", Page.ResolveUrl("~/ClientScripts/AjaxDivView.js"))

            ' Register Refresh function
            Dim eRef As String = Page.ClientScript.GetCallbackEventReference(Me, Nothing, "AjaxDivView_Result", "'" & Me.ClientID & "'", "AjaxDivView_Error", False)
            Dim refreshFunc As String = "function AjaxDivView_Refresh() {" & eRef & "}"
            Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), Me.UniqueID, refreshFunc, True)

            MyBase.OnPreRender(e)
        End Sub


        ''' <summary>
        ''' Iterate through the data items and instantiate each data
        ''' item in a template
        ''' </summary>
        Protected Overrides Function CreateChildControls(ByVal dataSource As IEnumerable, ByVal dataBinding As Boolean) As Integer
            Dim counter As Integer = 0
            For Each dataItem As Object In dataSource
                Dim contentItem As New DivViewItem(dataItem, counter)
                _itemTemplate.InstantiateIn(contentItem)
                Controls.Add(contentItem)
                counter = counter + 1
            Next
            DataBind(False)
            Return counter
        End Function

        ''' <summary>
        ''' Render this control's contents in a DIV tag
        ''' </summary>
        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

        ''' <summary>
        ''' Whenever I get called through AJAX,
        ''' rebind my data
        ''' </summary>
        Public Sub RaiseCallbackEvent(ByVal eventArgument As String) Implements ICallbackEventHandler.RaiseCallbackEvent
            Me.DataBind()
        End Sub

        ''' <summary>
        ''' Render my contents to a string
        ''' and send the result back to the client
        ''' </summary>
        Public Function GetCallbackResult() As String Implements ICallbackEventHandler.GetCallbackResult
            Dim builder As New StringBuilder()
            Dim sWriter As New StringWriter(builder)
            Dim hWriter As New HtmlTextWriter(sWriter)
            Me.RenderContents(hWriter)
            Return builder.ToString()
        End Function

    End Class


    Public Class AjaxDivViewItem
        Inherits WebControl
        Implements IDataItemContainer

        Private _dataItem As Object
        Private _index As Integer


        Public ReadOnly Property DataItem() As Object Implements IDataItemContainer.DataItem
            Get
                Return _dataItem
            End Get
        End Property

        Public ReadOnly Property DataItemIndex() As Integer Implements IDataItemContainer.DataItemIndex
            Get
                Return _index
            End Get
        End Property

        Public ReadOnly Property DisplayIndex() As Integer Implements IDataItemContainer.DisplayIndex
            Get
                Return _index
            End Get
        End Property

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

        Public Sub New(ByVal dataItem As Object, ByVal index As Integer)
            _dataItem = dataItem
            _index = index
        End Sub

    End Class
End Namespace

