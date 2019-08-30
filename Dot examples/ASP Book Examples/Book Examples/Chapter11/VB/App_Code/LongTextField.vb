Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls

Namespace myControls
    ''' <summary>
    ''' Enables you to display a long text field
    ''' </summary>
    Public Class LongTextField
        Inherits BoundField

        Private _width As Unit = New Unit("250px")
        Private _height As Unit = New Unit("60px")

        ''' <summary>
        ''' The Width of the field
        ''' </summary>
        Public Property Width() As Unit
            Get
                Return _width
            End Get
            Set(ByVal Value As Unit)
                _width = Value
            End Set
        End Property

        ''' <summary>
        ''' The Height of the field
        ''' </summary>
        Public Property Height() As Unit
            Get
                Return _height
            End Get
            Set(ByVal Value As Unit)
                _height = Value
            End Set
        End Property

        ''' <summary>
        ''' Builds the contents of the field
        ''' </summary>
        Protected Overrides Sub InitializeDataCell(ByVal cell As DataControlFieldCell, ByVal rowState As DataControlRowState)
            ' If not editing, show in scrolling div
            If (rowState And DataControlRowState.Edit) = 0 Then
                Dim div As HtmlGenericControl = New HtmlGenericControl("div")
                div.Attributes("class") = "longTextField"
                div.Style(HtmlTextWriterStyle.Width) = _width.ToString()
                div.Style(HtmlTextWriterStyle.Height) = _height.ToString()
                div.Style(HtmlTextWriterStyle.Overflow) = "auto"

                AddHandler div.DataBinding, AddressOf div_DataBinding

                cell.Controls.Add(div)
            Else
                Dim txtEdit As TextBox = New TextBox()
                txtEdit.TextMode = TextBoxMode.MultiLine
                txtEdit.Width = _width
                txtEdit.Height = _height

                AddHandler txtEdit.DataBinding, AddressOf txtEdit_DataBinding

                cell.Controls.Add(txtEdit)
            End If
        End Sub

        ''' <summary>
        ''' Called when databound in display mode
        ''' </summary>
        Private Sub div_DataBinding(ByVal s As Object, ByVal e As EventArgs)
            Dim div As HtmlGenericControl = CType(s, HtmlGenericControl)

            ' Get the field value
            Dim value As Object = Me.GetValue(div.NamingContainer)

            ' Assign the formatted value
            div.InnerText = Me.FormatDataValue(value, Me.HtmlEncode)
        End Sub

        ''' <summary>
        ''' Called when databound in edit mode
        ''' </summary>
        Private Sub txtEdit_DataBinding(ByVal s As Object, ByVal e As EventArgs)
            Dim txtEdit As TextBox = CType(s, TextBox)

            ' Get the field value
            Dim value As Object = Me.GetValue(txtEdit.NamingContainer)

            ' Assign the formatted value
            txtEdit.Text = Me.FormatDataValue(value, Me.HtmlEncode)
        End Sub

    End Class
End Namespace

