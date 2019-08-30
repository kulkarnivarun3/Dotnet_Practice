Imports System
Imports System.Configuration
Imports System.Drawing

Namespace AspNetUnleashed
    Public Class DesignSection
        Inherits ConfigurationSection

        <ConfigurationProperty("backcolor", DefaultValue:="lightblue", IsRequired:=True)> _
        Public Property BackColor() As Color
            Get
                Return CType(Me("backcolor"), Color)
            End Get
            Set(ByVal Value As Color)
                Me("backcolor") = Value
            End Set
        End Property

        <ConfigurationProperty("styleSheetUrl", DefaultValue:="~/styles/style.css", IsRequired:=True)> _
        <RegexStringValidator(".css$")> _
        Public Property StyleSheetUrl() As String
            Get
                Return CType(Me("styleSheetUrl"), String)
            End Get
            Set(ByVal Value As String)
                Me("styleSheetUrl") = Value
            End Set
        End Property

        Public Sub New(ByVal backcolor As Color, ByVal styleSheetUrl As String)
            Me.BackColor = backcolor
            Me.StyleSheetUrl = styleSheetUrl
        End Sub

        Public Sub New()
        End Sub
    End Class
End Namespace

