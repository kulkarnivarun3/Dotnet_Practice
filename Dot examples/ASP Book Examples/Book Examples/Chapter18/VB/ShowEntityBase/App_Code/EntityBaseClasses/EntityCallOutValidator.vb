Imports System
Imports System.Data
Imports System.Configuration
Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Xml.Linq


namespace Superexpert.Controls


    ''' <summary>
    ''' Summary description for EntityValidator
    ''' </summary>
    Public Class EntityCallOutValidator
        Inherits EntityValidator

        Protected Overrides Sub AddAttributesToRender(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute")
            writer.AddStyleAttribute(HtmlTextWriterStyle.ZIndex, "999")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Width, "400px")

            MyBase.AddAttributesToRender(writer)
        End Sub

        Protected Overrides ReadOnly Property TagKey() As HtmlTextWriterTag
            Get
                Return HtmlTextWriterTag.Div
            End Get
        End Property


        Protected Overrides Sub RenderContents(ByVal writer As HtmlTextWriter)

            RenderCallOutBox(writer)
            RenderCallOutImage(writer)
        End Sub

        Private Sub RenderCallOutBox(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Top, "0px")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Left, "27px")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "10px")
            writer.AddStyleAttribute("padding-right", "18px")
            writer.AddStyleAttribute("border", "1px solid black")
            writer.AddStyleAttribute("font", "small Arial")
            writer.AddStyleAttribute(HtmlTextWriterStyle.BackgroundColor, "#ffffc0")
            writer.RenderBeginTag(HtmlTextWriterTag.Div)
            writer.Write(Me.Text)

            RenderCloseBox(writer)

            writer.RenderEndTag()
        End Sub

        Private Sub RenderCallOutImage(ByVal writer As HtmlTextWriter)
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Top, "8px")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Left, "0px")

            writer.AddAttribute(HtmlTextWriterAttribute.Src, Page.ResolveUrl("~/Images/CallOut.gif"))
            writer.RenderBeginTag(HtmlTextWriterTag.Img)
            writer.RenderEndTag()
        End Sub


        Private Sub RenderCloseBox(ByVal writer As HtmlTextWriter)
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, "this.parentNode.parentNode.style.display='none';")


            writer.AddStyleAttribute(HtmlTextWriterStyle.Cursor, "hand")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute")
            writer.AddStyleAttribute(HtmlTextWriterStyle.Top, "0px")
            writer.AddStyleAttribute("right", "0px")

            writer.AddAttribute(HtmlTextWriterAttribute.Src, Page.ResolveUrl("~/Images/Close.gif"))
            writer.RenderBeginTag(HtmlTextWriterTag.Img)
            writer.RenderEndTag()
        End Sub


End Class
End Namespace