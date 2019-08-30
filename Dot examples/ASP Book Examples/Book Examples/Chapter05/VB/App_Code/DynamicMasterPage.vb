Imports Microsoft.VisualBasic

Public Class DynamicMasterPage
    Inherits Page

    Protected Overrides Sub OnPreInit(ByVal e As EventArgs)
        Me.MasterPageFile = CType(Context.Profile("MasterPageFile"), String)
        MyBase.OnPreInit(e)
    End Sub

End Class
