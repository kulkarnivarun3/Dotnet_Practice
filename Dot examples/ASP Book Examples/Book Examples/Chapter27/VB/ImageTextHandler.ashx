<%@ WebHandler Language="VB" Class="ImageTextHandler" %>

Imports System
Imports System.Web
Imports System.Drawing
Imports System.Drawing.Imaging
 
Public Class ImageTextHandler
	 Implements IHttpHandler
 
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        ' Get parameters from querystring
        Dim text As String = context.Request.QueryString("text")
        Dim font As String = context.Request.QueryString("font")
        Dim size As String = context.Request.QueryString("size")
 
        ' Create Font
        Dim fntText As New Font(font, Single.Parse(size))
 
        ' Calculate image width and height
        Dim bmp As New Bitmap(10, 10)
        Dim g As Graphics = Graphics.FromImage(bmp)
        Dim bmpSize As SizeF = g.MeasureString(text, fntText)
        Dim width As Integer = CType(Math.Ceiling(bmpSize.Width), Integer)
        Dim height As Integer = CType(Math.Ceiling(bmpSize.Height), Integer)
        bmp = New Bitmap(bmp, width, height)
        g.Dispose()
 
        ' Draw the text
        g = Graphics.FromImage(bmp)
        g.Clear(Color.White)
        g.DrawString(text, fntText, Brushes.Black, New PointF(0, 0))
        g.Dispose()
 
        ' Save bitmap to output stream
        bmp.Save(context.Response.OutputStream, ImageFormat.Gif)
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return True
        End Get
    End Property
 
End Class
