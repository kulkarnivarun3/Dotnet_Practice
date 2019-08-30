Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls

Namespace MyControls


    ''' <summary>
    ''' Enables you to select mulitple list items
    ''' from two list boxes
    ''' </summary>
    <ValidationProperty("SelectedItem")> _
    Public Class MultiSelectList
        Inherits ListControl
        Implements IPostBackDataHandler

        Private _rows As Integer = 5
        Private _UnSelectedWidth As Unit = Unit.Parse("300px")
        Private _SelectedWidth As Unit = Unit.Parse("300px")


        ''' <summary>
        ''' This control is contained in a div
        ''' tag
        ''' </summary>
        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute("position", "relative")
            MyBase.AddAttributesToRender(writer)
        End Sub

        ''' <summary>
        ''' The number of rows of list items to display
        ''' </summary>
        Public Property Rows() As Integer
            Get
                Return _rows
            End Get
            Set(ByVal value As Integer)
                _rows = value
            End Set
        End Property


        ''' <summary>
        ''' Name passed to client-side script
        ''' </summary>
        Private ReadOnly Property BaseName() As String
            Get
                Return ClientID & ClientIDSeparator
            End Get
        End Property

        ''' <summary>
        ''' Name of unselected items list box
        ''' </summary>
        Private ReadOnly Property UnselectedListName() As String
            Get
                Return BaseName & "unselected"
            End Get
        End Property

        ''' <summary>
        ''' Name of selected items list box
        ''' </summary>
        Private ReadOnly Property SelectedListName() As String
            Get
                Return BaseName & "selected"
            End Get
        End Property

        ''' <summary>
        ''' Name of hidden input field
        ''' </summary>
        Private ReadOnly Property HiddenName() As String
            Get
                Return BaseName & "hidden"
            End Get
        End Property

        ''' <summary>
        ''' Register client scripts
        ''' </summary>
        Protected Overrides Sub OnPreRender(ByVal e As EventArgs)
            Page.RegisterRequiresPostBack(Me)

            ' Register hidden field
            Page.ClientScript.RegisterHiddenField(HiddenName, String.Empty)

            ' Register Include File
            If (Not Page.ClientScript.IsClientScriptIncludeRegistered("MultiSelectList")) Then
                Page.ClientScript.RegisterClientScriptInclude("MultiSelectList", Page.ResolveUrl("~/ClientScripts/MultiSelectList.js"))
            End If

            ' Register submit script
            Dim submitScript As String = String.Format("multiSelectList_submit('{0}')", BaseName)
            Page.ClientScript.RegisterOnSubmitStatement(Me.GetType(), Me.ClientID, submitScript)

            MyBase.OnPreRender(e)
        End Sub

        ''' <summary>
        ''' Render list boxes and buttons
        ''' </summary>
        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            ' Render Unselected
            RenderUnselected(writer)

            ' Render Buttons
            RenderButtons(writer)

            ' Render Selected
            RenderSelected(writer)

            ' Render clear break
            writer.AddStyleAttribute("clear", "both")
            writer.RenderBeginTag(HtmlTextWriterTag.Br)
            writer.RenderEndTag()
        End Sub

        ''' <summary>
        ''' Render the buttons
        ''' </summary>
        Private Sub RenderButtons(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute("float", "left")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "10px")
            writer.AddStyleAttribute(HtmlTextWriterStyle.TextAlign, "center")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)

            Dim addScript As String = String.Format("return multiSelectList_add('{0}')", BaseName)
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, addScript)
            writer.AddAttribute(HtmlTextWriterAttribute.Title, "Add Item")
            writer.RenderBeginTag(HtmlTextWriterTag.Button)
            writer.Write("--&gt")
            writer.RenderEndTag()
            writer.WriteBreak()
            Dim removeScript As String = String.Format("return multiSelectList_remove('{0}')", BaseName)
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, removeScript)
            writer.AddAttribute(HtmlTextWriterAttribute.Title, "Remove Item")
            writer.RenderBeginTag(HtmlTextWriterTag.Button)
            writer.Write("&lt--")
            writer.RenderEndTag()

            writer.RenderEndTag()
        End Sub

        ''' <summary>
        ''' Render unselected list box
        ''' </summary>
        Private Sub RenderUnselected(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute("float", "left")
            writer.AddAttribute(HtmlTextWriterAttribute.Size, _rows.ToString())
            writer.AddStyleAttribute(HtmlTextWriterStyle.Width, _UnSelectedWidth.ToString())
            writer.AddAttribute(HtmlTextWriterAttribute.Id, UnselectedListName)
            writer.AddAttribute(HtmlTextWriterAttribute.Name, UnselectedListName)
            writer.AddAttribute(HtmlTextWriterAttribute.Multiple, "true")
            writer.RenderBeginTag(HtmlTextWriterTag.Select)
            For Each item As ListItem In Items
                If Not item.Selected Then
                    RenderListItem(writer, item)
                End If
            Next
            writer.RenderEndTag()
        End Sub

        ''' <summary>
        ''' Render selected list items
        ''' </summary>
        Private Sub RenderSelected(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute("float", "left")
            writer.AddAttribute(HtmlTextWriterAttribute.Size, _rows.ToString())
            writer.AddStyleAttribute(HtmlTextWriterStyle.Width, _SelectedWidth.ToString())
            writer.AddAttribute(HtmlTextWriterAttribute.Id, SelectedListName)
            writer.AddAttribute(HtmlTextWriterAttribute.Name, SelectedListName)
            writer.AddAttribute(HtmlTextWriterAttribute.Multiple, "true")
            writer.RenderBeginTag(HtmlTextWriterTag.Select)
            For Each item As ListItem In Items
                If item.Selected Then
                    RenderListItem(writer, item)
                End If
            Next
            writer.RenderEndTag()
        End Sub

        ''' <summary>
        ''' Render a list item
        ''' </summary>
        Private Sub RenderListItem(ByVal writer As HtmlTextWriter, ByVal item As ListItem)
            writer.AddAttribute(HtmlTextWriterAttribute.Value, item.Value)
            writer.RenderBeginTag(HtmlTextWriterTag.Option)
            writer.Write(item.Text)
            writer.RenderEndTag()
        End Sub

        ''' <summary>
        ''' Process postback data
        ''' </summary>
        Public Function LoadPostData(ByVal postDataKey As String, ByVal postCollection As System.Collections.Specialized.NameValueCollection) As Boolean Implements IPostBackDataHandler.LoadPostData
            EnsureDataBound()
            ClearSelection()

            Dim values As String = postCollection(HiddenName)
            If values <> String.Empty Then
                Dim splitValues As String() = values.Split(",")
                For Each value As String In splitValues
                    Items.FindByValue(value).Selected = True
                Next
            End If
            Return False
        End Function

        ''' <summary>
        ''' Required by the IPostBackDataHandler interface
        ''' </summary>
        Public Sub RaisePostDataChangedEvent() Implements IPostBackDataHandler.RaisePostDataChangedEvent
        End Sub


    End Class
End Namespace