Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Generic

Namespace MyControls

Public Class Glow
    Inherits ScriptControl

    Private _Text As String = "Glow Control"
    Private _BackgroundColor As String = "orange"

    Public Property Text() As String
        Get
            Return _Text
        End Get
        Set(ByVal value As String)
            _Text = value
        End Set
    End Property

    Public Property BackgroundColor() As String
        Get
            Return _BackgroundColor
        End Get
        Set(ByVal value As String)
            _BackgroundColor = value
        End Set
    End Property

    Protected Overrides Function GetScriptReferences() As IEnumerable(Of ScriptReference)
        Dim sref As New ScriptReference("Glow.js")
        Dim colSRefs As New List(Of ScriptReference)()
        colSRefs.Add(sref)
        Return colSRefs
    End Function

    Protected Overrides Function GetScriptDescriptors() As IEnumerable(Of ScriptDescriptor)
        Dim des As New ScriptControlDescriptor("myControls.Glow", Me.ClientID)
        des.AddProperty("text", _Text)
        des.AddProperty("backgroundColor", _BackgroundColor)
        Dim colDes As New List(Of ScriptDescriptor)()
        colDes.Add(des)
        Return colDes
    End Function
End Class
End Namespace