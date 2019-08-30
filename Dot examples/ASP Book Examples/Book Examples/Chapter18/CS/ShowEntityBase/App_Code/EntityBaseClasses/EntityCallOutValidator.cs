using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;


namespace Superexpert.Controls
{

    /// <summary>
    /// Summary description for EntityValidator
    /// </summary>
    public class EntityCallOutValidator : EntityValidator
    {

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute");
            writer.AddStyleAttribute(HtmlTextWriterStyle.ZIndex, "999");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Width, "400px");
        
            base.AddAttributesToRender(writer);
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }




        protected override void RenderContents(HtmlTextWriter writer)
        {
            
            RenderCallOutBox(writer);           
            RenderCallOutImage(writer);
        }
        
        private void RenderCallOutBox(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Top, "0px");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Left, "27px");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "10px");
            writer.AddStyleAttribute("padding-right", "18px");
            writer.AddStyleAttribute("border", "1px solid black");
            writer.AddStyleAttribute("font", "small Arial");
            writer.AddStyleAttribute(HtmlTextWriterStyle.BackgroundColor, "#ffffc0");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.Write(this.Text);

            RenderCloseBox(writer);
        
            writer.RenderEndTag();
 
        
        }
        
        private void RenderCallOutImage(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Top, "8px");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Left, "0px");

            writer.AddAttribute(HtmlTextWriterAttribute.Src, Page.ResolveUrl("~/Images/CallOut.gif"));
            writer.RenderBeginTag(HtmlTextWriterTag.Img);
            writer.RenderEndTag();
       
        }        


        private void RenderCloseBox(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Onclick, "this.parentNode.parentNode.style.display='none';");
        
        
            writer.AddStyleAttribute(HtmlTextWriterStyle.Cursor, "hand");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Position, "absolute");
            writer.AddStyleAttribute(HtmlTextWriterStyle.Top, "0px");
            writer.AddStyleAttribute("right", "0px");

            writer.AddAttribute(HtmlTextWriterAttribute.Src, Page.ResolveUrl("~/Images/Close.gif"));
            writer.RenderBeginTag(HtmlTextWriterTag.Img);
            writer.RenderEndTag();
        }


    }
}