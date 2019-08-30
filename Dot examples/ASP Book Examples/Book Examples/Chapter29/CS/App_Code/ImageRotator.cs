using System;
using System.Collections;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace myControls
{
    [ParseChildren(true, "ImageItems")]
    public class ImageRotator : WebControl
    {
        private ArrayList _imageItems = new ArrayList();

        public ArrayList ImageItems
        {
            get
            {
                return _imageItems;
            }
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            if (_imageItems.Count > 0)
            {
                Random rnd = new Random();
                ImageItem img = (ImageItem)_imageItems[rnd.Next(_imageItems.Count)];
                writer.AddAttribute(HtmlTextWriterAttribute.Src, img.ImageUrl);
                writer.AddAttribute(HtmlTextWriterAttribute.Alt, img.AlternateText);
                writer.RenderBeginTag(HtmlTextWriterTag.Img);
                writer.RenderEndTag();
            }
        }
    }

    public class ImageItem
    {
        private string _imageUrl;
        private string _alternateText;

        public string ImageUrl
        {
            get { return _imageUrl; }
            set { _imageUrl = value; }
        }

        public string AlternateText
        {
            get { return _alternateText; }
            set { _alternateText = value; }
        }
    }
}