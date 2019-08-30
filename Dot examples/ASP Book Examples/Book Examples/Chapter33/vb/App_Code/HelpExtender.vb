Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Generic

Namespace MyControls

<TargetControlType(GetType(TextBox))> _
Public Class HelpExtender
Inherits ExtenderControl

    Private _Text As String = "Help Text..."

    Public Property Text() As String
        Get
            Return _Text
        End Get
        Set(ByVal value As String)
            _Text = value
        End Set
    End Property

    Protected Overrides Function GetScriptReferences() As IEnumerable(Of ScriptReference)
        Dim sref As New ScriptReference("~/HelpBehavior.js")
        Dim colSRefs As New List(Of ScriptReference)()
        colSRefs.Add(sref)
        Return colSRefs
    End Function

    Protected Overrides Function GetScriptDescriptors(ByVal targetControl As Control) As IEnumerable(Of ScriptDescriptor)
        Dim des As New ScriptControlDescriptor("myControls.HelpBehavior", TargetControlID)
        des.AddProperty("text", _Text)
        Dim colDes As New List(Of ScriptDescriptor)()
        colDes.Add(des)
        Return colDes
    End Function

End Class
End Namespace