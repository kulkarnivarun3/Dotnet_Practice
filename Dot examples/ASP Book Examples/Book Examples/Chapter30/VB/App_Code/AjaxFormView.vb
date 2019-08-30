Imports System
Imports System.Collections
Imports System.Collections.Specialized
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.ComponentModel

Namespace AspNetUnleashed
    Public Class AjaxFormView
        Inherits CompositeDataBoundControl
        Implements ICallbackEventHandler

        Const scriptPath As String = "~/ClientScripts/AjaxFormView.js"

        Private _insertItemTemplate As IBindableTemplate
        Private _editItemTemplate As IBindableTemplate
        Private _item As AjaxFormViewItem
        Private _defaultMode As AjaxFormViewMode = AjaxFormViewMode.Edit
        Private _clientCallbackResult As String
        Private _dataKeyNames() As String
        Private _dataKey As DataKey
        Private _keyTable As OrderedDictionary
        Private _onClientItemInserted As String = "AjaxFormView_ItemInserted"
        Private _onClientItemUpdated As String = "AjaxFormView_ItemUpdated"


        ''' <summary>
        ''' Represents the template for inserting new items
        ''' </summary>
        <TemplateContainer(GetType(AjaxFormViewItem), BindingDirection.TwoWay)> _
        <PersistenceMode(PersistenceMode.InnerProperty)> _
        Public Property InsertItemTemplate() As IBindableTemplate
            Get
                Return _insertItemTemplate
            End Get
            Set(ByVal Value As IBindableTemplate)
                _insertItemTemplate = Value
            End Set
        End Property

        ''' <summary>
        ''' Represents the template for editing items
        ''' </summary>
        <TemplateContainer(GetType(AjaxFormViewItem), BindingDirection.TwoWay)> _
        <PersistenceMode(PersistenceMode.InnerProperty)> _
        Public Property EditItemTemplate() As IBindableTemplate
            Get
                Return _editItemTemplate
            End Get
            Set(ByVal Value As IBindableTemplate)
                _editItemTemplate = Value
            End Set
        End Property

        ''' <summary>
        ''' Represents the primary keys from the database. 
        ''' </summary>
        <TypeConverter(GetType(StringArrayConverter))> _
        Public Property DataKeyNames() As String()
            Get
                Return _dataKeyNames
            End Get
            Set(ByVal Value As String())
                _dataKeyNames = Value
            End Set
        End Property

        ''' <summary>
        ''' Represents the current DataKey. This
        ''' is need for updating a record
        ''' </summary>
        Public ReadOnly Property DataKey() As DataKey
            Get
                If _dataKey Is Nothing Then
                    _dataKey = New DataKey(_keyTable)
                End If
                Return _dataKey
            End Get
        End Property

        ''' <summary>
        ''' Enables you to place the control in
        ''' either Insert or Edit mode
        ''' </summary>
        Public Property DefaultMode() As AjaxFormViewMode
            Get
                Return _defaultMode
            End Get
            Set(ByVal Value As AjaxFormViewMode)
                _defaultMode = value
            End Set
        End Property

        ''' <summary>
        ''' Enables you to execute a custom
        ''' Javascript when an item is inserted
        ''' </summary>
        Public Property OnClientItemInserted() As String
            Get
                Return _onClientItemInserted
            End Get
            Set(ByVal Value As String)
                _onClientItemInserted = value
            End Set
        End Property


        ''' <summary>
        ''' Enables you to execute a custom
        ''' Javascript when an item is updated
        ''' </summary>
        Public Property OnClientItemUpdated() As String
            Get
                Return _onClientItemUpdated
            End Get
            Set(ByVal Value As String)
                _onClientItemUpdated = value
            End Set
        End Property


        ''' <summary>
        ''' Register that we need Control State. The
        ''' DataKey is stored in Control State.
        ''' </summary>
        Protected Overrides Sub OnInit(ByVal e As EventArgs)
            Page.RegisterRequiresControlState(Me)
            MyBase.OnInit(e)
        End Sub

        ''' <summary>
        ''' Register the JavaScript AJAX script
        ''' </summary>
        Protected Overrides Sub OnPreRender(ByVal e As EventArgs)
            Page.ClientScript.RegisterClientScriptInclude("AjaxFormView", Page.ResolveUrl(scriptPath))
            MyBase.OnPreRender(e)
        End Sub

        ''' <summary>
        ''' Create either the InsertItemTemplate or the EditItemTemplate
        ''' </summary>
        Protected Overrides Function CreateChildControls(ByVal dataSource As IEnumerable, ByVal dataBinding As Boolean) As Integer
            If _defaultMode = AjaxFormViewMode.Edit Then
                _item = GetEditItem(dataSource, dataBinding)
                _editItemTemplate.InstantiateIn(_item)
            Else
                _item = New AjaxFormViewItem()
                _insertItemTemplate.InstantiateIn(_item)
            End If
            Controls.Add(_item)
            DataBind(False)

            Return 1
        End Function

        ''' <summary>
        ''' Get the first item from the data source and grab
        ''' the data keys
        ''' </summary>
        Private Function GetEditItem(ByVal dataSource As IEnumerable, ByVal dataBinding As Boolean) As AjaxFormViewItem
            Dim editItem As AjaxFormViewItem = Nothing
            If Not IsNothing(dataSource) Then
                Dim en As IEnumerator = dataSource.GetEnumerator()
                If en.MoveNext() Then
                    editItem = New AjaxFormViewItem(en.Current)
                    If Not _dataKeyNames Is Nothing Then
                        If dataBinding Then
                            _keyTable = New OrderedDictionary()
                            For Each key As String In _dataKeyNames
                                _keyTable.Add(key, DataBinder.Eval(en.Current, key))
                            Next
                        End If
                    End If
                End If
            End If
            Return editItem
        End Function

        ''' <summary>
        ''' Render the Insert or Edit button at the bottom
        ''' of the normal control content
        ''' </summary>
        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            ' Render the template
            MyBase.RenderContents(writer)

            ' Render either the Edit or Insert button
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            If _defaultMode = AjaxFormViewMode.Edit Then
                RenderUpdateButton(writer)
            Else
                RenderInsertButton(writer)
            End If
            writer.RenderEndTag()
        End Sub

        ''' <summary>
        ''' Render the Update button with the AJAX onclick handler
        ''' </summary>
        Private Sub RenderUpdateButton(ByVal writer As HtmlTextWriter)
            Dim eRef As String = Page.ClientScript.GetCallbackEventReference(Me, "'update'", _onClientItemUpdated, "'" & Me.ClientID & "'", "AjaxFormView_Error", True)
            eRef = "__theFormPostData='';WebForm_InitCallback();" & eRef & ";return false"
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, eRef)
            writer.RenderBeginTag(HtmlTextWriterTag.Button)
            writer.Write("Update")
            writer.RenderEndTag()
        End Sub


        ''' <summary>
        ''' Render the Insert button with the AJAX onclick handler
        ''' </summary>
        Private Sub RenderInsertButton(ByVal writer As HtmlTextWriter)
            Dim eRef As String = Page.ClientScript.GetCallbackEventReference(Me, "'insert'", _onClientItemInserted, "'" & Me.ClientID & "'", "AjaxFormView_Error", False)
            eRef = "__theFormPostData='';WebForm_InitCallback();" & eRef & ";return false"
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, eRef)
            writer.RenderBeginTag(HtmlTextWriterTag.Button)
            writer.Write("Insert")
            writer.RenderEndTag()
        End Sub

        ''' <summary>
        ''' Render this control in a DIV
        ''' </summary>
        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

        ''' <summary>
        ''' Called on the server by AJAX on the client
        ''' </summary>
        Public Sub RaiseCallbackEvent(ByVal eventArgument As String) Implements ICallbackEventHandler.RaiseCallbackEvent
            Select Case eventArgument
                Case "update"
                    HandleUpdate()
                    Exit Sub
                Case "insert"
                    HandleInsert()
                    Exit Sub
            End Select
        End Sub

        ''' <summary>
        ''' Perform database update by executing DataSource Update method
        ''' </summary>
        Private Sub HandleUpdate()
            Dim values As IOrderedDictionary = _editItemTemplate.ExtractValues(_item)
            Dim dataSource As DataSourceView = CType(Me.GetData(), DataSourceView)
            dataSource.Update(DataKey.Values, values, Nothing, AddressOf DataCallback)
        End Sub

        ''' <summary>
        ''' Perform database insert by executing DataSource Insert method
        ''' </summary>
        Private Sub HandleInsert()
            Dim values As IOrderedDictionary = _insertItemTemplate.ExtractValues(_item)
            Dim dataSource As DataSourceView = CType(Me.GetData(), DataSourceView)
            dataSource.Insert(values, AddressOf DataCallback)
        End Sub

        ''' <summary>
        ''' Called after asynchronous database command completes
        ''' </summary>
        Private Function DataCallback(ByVal affectedRecords As Integer, ByVal ex As Exception) As Boolean
            If Not IsNothing(ex) Then
                _clientCallbackResult = ex.Message
            End If
            Return True
        End Function

        ''' <summary>
        ''' Return AJAX callback result to client
        ''' </summary>
        Public Function GetCallbackResult() As String Implements ICallbackEventHandler.GetCallbackResult
            Return _clientCallbackResult
        End Function

        ''' <summary>
        ''' Save data keys in Control State
        ''' </summary>
        Protected Overrides Function SaveControlState() As Object
            Return _keyTable
        End Function

        ''' <summary>
        ''' Load data keys from Control State
        ''' </summary>
        Protected Overrides Sub LoadControlState(ByVal savedState As Object)
            _keyTable = CType(savedState, OrderedDictionary)
        End Sub

    End Class

    ''' <summary>
    ''' Represents an AjaxFormView data item. Also acts as a container
    ''' for an EditItemTemplate or InsertItemTemplate
    ''' </summary>
    Public Class AjaxFormViewItem
        Inherits WebControl
        Implements IDataItemContainer

        Private _dataItem As Object

        Public ReadOnly Property DataItem() As Object Implements IDataItemContainer.DataItem
            Get
                Return _dataItem
            End Get
        End Property

        Public ReadOnly Property DataItemIndex() As Integer Implements IDataItemContainer.DataItemIndex
            Get
                Return 0
            End Get
        End Property

        Public ReadOnly Property DisplayIndex() As Integer Implements IDataItemContainer.DisplayIndex
            Get
                Return 0
            End Get
        End Property

        Public Sub New(ByVal dataItem As Object)
            _dataItem = dataItem
        End Sub

        Public Sub New()
        End Sub
    End Class


    Public Enum AjaxFormViewMode
        Edit = 0
        Insert = 1
    End Enum


End Namespace

