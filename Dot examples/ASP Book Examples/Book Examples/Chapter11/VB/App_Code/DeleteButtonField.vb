Imports System
Imports System.Web.UI.WebControls

Namespace myControls
    ''' <summary>
    ''' Displays a confirmation before deleting a record
    ''' </summary>
    Public Class DeleteButtonField
        Inherits ButtonField

        Private _confirmText As String = "Delete this record?"

        Public Property ConfirmText() As String
            Get
                Return _confirmText
            End Get
            Set(ByVal Value As String)
                _confirmText = value
            End Set
        End Property

        Public Sub New()
            Me.CommandName = "Delete"
            Me.Text = "Delete"
        End Sub

        Public Overrides Sub InitializeCell(ByVal cell As DataControlFieldCell, ByVal cellType As DataControlCellType, ByVal rowState As DataControlRowState, ByVal rowIndex As Integer)
            MyBase.InitializeCell(cell, cellType, rowState, rowIndex)
            If cellType = DataControlCellType.DataCell Then
                Dim button As WebControl = CType(cell.Controls(0), WebControl)
                button.Attributes("onclick") = String.Format("return confirm('{0}');", _confirmText)
            End If
        End Sub

    End Class
End Namespace

