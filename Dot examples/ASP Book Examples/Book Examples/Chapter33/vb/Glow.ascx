<%@ Control Language="vb" ClassName="Glow" %>
<%@ Implements Interface="System.Web.UI.IScriptControl" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    private _Text as String = "Glow Control"
    private _BackgroundColor As String = "orange"

    public property Text As String 
        get 
            return _Text 
        end get
        set 
            _Text = value 
        end set
    end Property
    
    public Property BackgroundColor as String
        get 
            return _BackgroundColor 
        end get
        set 
            _BackgroundColor = value 
        end set
    End Property

    Public Function GetScriptReferences() As IEnumerable(Of ScriptReference) Implements IScriptControl.GetScriptReferences
        Dim sref As New ScriptReference("Glow.js")
        Dim colSRefs As New List(Of ScriptReference)()
        colSRefs.Add(sref)
        Return colSRefs
    End Function

    Public Function GetScriptDescriptors() As IEnumerable(Of ScriptDescriptor) Implements IScriptControl.GetScriptDescriptors
        Dim des As New ScriptControlDescriptor("myControls.Glow", Me.ClientID)
        des.AddProperty("text", _Text)
        des.AddProperty("backgroundColor", _BackgroundColor)
        Dim colDes As New List(Of ScriptDescriptor)()
        colDes.Add(des)
        Return colDes
    End Function

    Protected Overrides Sub OnPreRender(ByVal e As EventArgs)
        ScriptManager.GetCurrent(Page).RegisterScriptControl(Me)
        MyBase.OnPreRender(e)
    End Sub


    Protected Overrides Sub Render(ByVal writer As HtmlTextWriter)
        ScriptManager.GetCurrent(Page).RegisterScriptDescriptors(Me)
        MyBase.Render(writer)
    End Sub

</script>

<div id='<%= me.ClientID %>'></div>