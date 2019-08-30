Imports System
Imports System.Collections.Generic
Imports System.Web.UI
Imports System.Web.UI.WebControls

namespace Superexpert.Controls



''' <summary>
''' Summary description for EntityDataSource
''' </summary>
Public Class EntityDataSource
Inherits ObjectDataSource

    Protected Overrides Sub OnInit(ByVal e As EventArgs)
        Me.DataObjectTypeName = Me.TypeName
        Me.ConflictDetection = ConflictOptions.CompareAllValues
        Me.OldValuesParameterFormatString = "oldEntity"

        If String.IsNullOrEmpty(Me.SelectMethod) Then
            Me.SelectMethod = "Select"
        End If
        If String.IsNullOrEmpty(Me.SelectCountMethod) Then
            Me.SelectCountMethod = "SelectCountCached"
        End If
        If (String.IsNullOrEmpty(Me.InsertMethod)) Then
            Me.InsertMethod = "Insert"
        End If
        If (String.IsNullOrEmpty(Me.UpdateMethod)) Then
            Me.UpdateMethod = "Update"
        End If
        If (String.IsNullOrEmpty(Me.DeleteMethod)) Then
            Me.DeleteMethod = "Delete"
        End If
        MyBase.OnInit(e)
    End Sub

End Class
End Namespace