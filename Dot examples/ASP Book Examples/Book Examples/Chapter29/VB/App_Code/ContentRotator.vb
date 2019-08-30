Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace myControls
    <ParseChildren(False)> _
    Public Class ContentRotator
        Inherits WebControl

        Protected Overrides Sub AddParsedSubObject(ByVal obj As Object)
            If TypeOf obj Is Content Then
                MyBase.AddParsedSubObject(obj)
            End If
        End Sub

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            Dim rnd As Random = New Random()
            Dim index As Integer = rnd.Next(Me.Controls.Count)
            Me.Controls(index).RenderControl(writer)
        End Sub
    End Class

    Public Class Content
        Inherits Control
    End Class
End Namespace
