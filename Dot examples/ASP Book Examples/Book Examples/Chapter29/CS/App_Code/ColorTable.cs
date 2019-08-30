using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace myControls
{
    public class ColorTable : WebControl
    {
        protected override void RenderContents(HtmlTextWriter writer)
        {
            // Get list of colors
            KnownColor[] colors = (KnownColor[])Enum.GetValues(typeof(KnownColor));

            // Render opening table tag
            writer.AddAttribute(HtmlTextWriterAttribute.Border, "1");
            writer.RenderBeginTag(HtmlTextWriterTag.Table);

            // Render table body
            foreach (KnownColor colorName in colors)
            {
                writer.RenderBeginTag(HtmlTextWriterTag.Tr);

                // Render first column
                writer.RenderBeginTag(HtmlTextWriterTag.Td);
                writer.Write(colorName);
                writer.RenderEndTag();

                // Render second column
                writer.AddAttribute(HtmlTextWriterAttribute.Width, "50px");
                writer.AddAttribute(HtmlTextWriterAttribute.Bgcolor, colorName.ToString());
                writer.RenderBeginTag(HtmlTextWriterTag.Td);
                writer.Write("&nbsp;");
                writer.RenderEndTag();

                writer.RenderEndTag();
            }

            // close table
            writer.RenderEndTag();
        }
    }
}