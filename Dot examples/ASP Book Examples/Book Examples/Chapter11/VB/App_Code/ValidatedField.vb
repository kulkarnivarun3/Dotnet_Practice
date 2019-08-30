Imports System
Imports System.Collections.Specialized
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    ''' <summary>
    ''' Adds RequiredFieldValidator and CompareValidator
    ''' to BoundField
    ''' </summary>
    Public Class ValidatedField
        Inherits BoundField

        Private _validationDataType As ValidationDataType = ValidationDataType.String

        Public Property ValidationDataType() As ValidationDataType
            Get
                Return _validationDataType
            End Get
            Set(ByVal Value As ValidationDataType)
                _validationDataType = Value
            End Set
        End Property

        ''' <summary>
        ''' Get value from TextBox
        ''' </summary>
        Public Overrides Sub ExtractValuesFromCell(ByVal dictionary As IOrderedDictionary, ByVal cell As DataControlFieldCell, ByVal rowState As DataControlRowState, ByVal includeReadOnly As Boolean)
            Dim edit As EditContainer = CType(cell.Controls(0), EditContainer)
            If dictionary.Contains(DataField) Then
                dictionary(DataField) = edit.Text
            Else
                dictionary.Add(DataField, edit.Text)
            End If
        End Sub

        ''' <summary>
        ''' Called when field is bound to data source
        ''' </summary>
        Protected Overrides Sub OnDataBindField(ByVal sender As Object, ByVal e As EventArgs)
            Dim source As Control = CType(sender, Control)

            ' Get the field value
            Dim value As Object = Me.GetValue(source.NamingContainer)

            ' If the control is a table cell, display the text
            If TypeOf source Is DataControlFieldCell Then
                Dim formattedValue As String = Me.FormatDataValue(value, Me.HtmlEncode)
                If formattedValue = String.Empty Then
                    formattedValue = "&nbsp;"
                End If
                CType(source, DataControlFieldCell).Text = formattedValue
            End If

            ' If the control is an editor, display the editor
            If TypeOf source Is EditContainer Then
                Dim formattedValue As String = String.Empty
                Select Case _validationDataType
                    Case ValidationDataType.Date
                        Dim vdate As DateTime = CType(value, DateTime)
                        formattedValue = vdate.ToShortDateString()
                    Case ValidationDataType.Currency
                        Dim dec As Decimal = CType(value, Decimal)
                        formattedValue = dec.ToString("F")
                    Case Else
                        formattedValue = value.ToString()
                End Select
                CType(source, EditContainer).Text = formattedValue
            End If
        End Sub

        ''' <summary>
        ''' Build the field 
        ''' </summary>
        Protected Overrides Sub InitializeDataCell(ByVal cell As DataControlFieldCell, ByVal rowState As DataControlRowState)
            If (rowState And DataControlRowState.Edit) = 0 Then
                AddHandler cell.DataBinding, AddressOf Me.OnDataBindField
            Else
                Dim editor As EditContainer = New EditContainer(DataField, _validationDataType)
                AddHandler editor.DataBinding, AddressOf Me.OnDataBindField
                cell.Controls.Add(editor)
            End If
        End Sub
    End Class

    ''' <summary>
    ''' This control is added to the field
    ''' </summary>
    Public Class EditContainer
        Inherits Control
        Implements INamingContainer

        Private _dataField As String
        Private _validationDataType As ValidationDataType

        Private _txtEdit As TextBox
        Private _valReq As RequiredFieldValidator
        Private _valCompare As CompareValidator

        Public Sub New(ByVal dataField As String, ByVal validationDataType As ValidationDataType)
            _dataField = dataField
            _validationDataType = validationDataType
        End Sub

        ''' <summary>
        ''' Expose the TextBox control's Text Property
        ''' </summary>
        Public Property Text() As String
            Get
                EnsureChildControls()
                Return _txtEdit.Text
            End Get
            Set(ByVal Value As String)
                EnsureChildControls()
                _txtEdit.Text = Value
            End Set
        End Property

        ''' <summary>
        ''' Add TextBox, RequiredFieldValidator, and
        ''' CompareValidator
        ''' </summary>
        Protected Overrides Sub CreateChildControls()
            ' Add the textbox
            _txtEdit = New TextBox()
            _txtEdit.ID = "txtEdit"
            Controls.Add(_txtEdit)

            ' Add a RequiredFieldValidator control
            _valReq = New RequiredFieldValidator()
            _valReq.Display = ValidatorDisplay.Dynamic
            _valReq.Text = "(required)"
            _valReq.ControlToValidate = _txtEdit.ID
            Controls.Add(_valReq)

            ' Add a CompareValidator control
            _valCompare = New CompareValidator()
            _valCompare.Display = ValidatorDisplay.Dynamic
            _valCompare.Operator = ValidationCompareOperator.DataTypeCheck
            _valCompare.Type = _validationDataType
            _valCompare.Text = "(invalid)"
            _valCompare.ControlToValidate = _txtEdit.ID
            Controls.Add(_valCompare)
        End Sub
    End Class
End Namespace
