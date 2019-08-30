Imports System
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Drawing

Namespace myControls
    Public Class ColorTable
        Inherits WebControl

        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)
            ' Get list of colors
            Dim colors() As KnownColor = CType(System.Enum.GetValues(GetType(KnownColor)), KnownColor())

            ' Render opening table tag
            writer.AddAttribute(HtmlTextWriterAttribute.Border, "1")
            writer.RenderBeginTag(HtmlTextWriterTag.Table)

            ' Render table body
            Dim colorName As KnownColor
            For Each colorName In colors
                writer.RenderBeginTag(HtmlTextWriterTag.Tr)

                ' Render first column
                writer.RenderBeginTag(HtmlTextWriterTag.Td)
                writer.Write(colorName.ToString())
                writer.RenderEndTag()

                ' Render second column
                writer.AddAttribute(HtmlTextWriterAttribute.Width, "50px")
                writer.AddAttribute(HtmlTextWriterAttribute.Bgcolor, colorName.ToString())
                writer.RenderBeginTag(HtmlTextWriterTag.Td)
                writer.Write("&nbsp;")
                writer.RenderEndTag()

                writer.RenderEndTag()
            Next

            ' close table
            writer.RenderEndTag()
        End Sub

    End Class
End Namespace

