<%@ WebHandler Language="C#" Class="ImageTextHandler" Debug="true" %>

using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;

public class ImageTextHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        // Get parameters from querystring
        string text = context.Request.QueryString["text"];
        string font = context.Request.QueryString["font"];
        string size = context.Request.QueryString["size"];

        // Create Font
        Font fntText = new Font(font, float.Parse(size));

        // Calculate image width and height
        Bitmap bmp = new Bitmap(10, 10);
        Graphics g = Graphics.FromImage(bmp);
        SizeF bmpSize = g.MeasureString(text, fntText);
        int width = (int)Math.Ceiling(bmpSize.Width);
        int height = (int)Math.Ceiling(bmpSize.Height);
        bmp = new Bitmap(bmp, width, height);
        g.Dispose();

        // Draw the text
        g = Graphics.FromImage(bmp);
        g.Clear(Color.White);
        g.DrawString(text, fntText, Brushes.Black, new PointF(0, 0));
        g.Dispose();

        // Save bitmap to output stream
        bmp.Save(context.Response.OutputStream, ImageFormat.Gif);
    }

    public bool IsReusable
    {
        get
        {
            return true;
        }
    }

}