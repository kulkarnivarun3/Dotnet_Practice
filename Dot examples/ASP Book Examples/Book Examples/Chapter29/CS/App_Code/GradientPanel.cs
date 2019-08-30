using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design;
using System.ComponentModel;
using System.Drawing;

namespace myControls
{
    [Designer(typeof(GradientPanelDesigner))]
    [ParseChildren(false)]
    public class GradientPanel : WebControl
    {
        private GradientDirection _direction = GradientDirection.Horizontal;
        private Color _startColor = Color.DarkBlue;
        private Color _endColor = Color.White;

        public GradientDirection Direction
        {
            get { return _direction; }
            set { _direction = value; }
        }

        public Color StartColor
        {
            get { return _startColor; }
            set { _startColor = value; }
        }

        public Color EndColor
        {
            get { return _endColor; }
            set { _endColor = value; }
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, this.GetFilterString());
            base.AddAttributesToRender(writer);
        }

        public string GetFilterString()
        {
            return String.Format("progid:DXImageTransform.Microsoft.Gradient(gradientType={0},startColorStr={1},endColorStr={2})", _direction.ToString("d"), ColorTranslator.ToHtml(_startColor), ColorTranslator.ToHtml(_endColor));
        }

        public GradientPanel()
        {
            this.Width = Unit.Parse("500px");
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }
    }

    public enum GradientDirection
    {
        Vertical = 0,
        Horizontal = 1
    }

    public class GradientPanelDesigner : ContainerControlDesigner
    {
        protected override void AddDesignTimeCssAttributes(System.Collections.IDictionary styleAttributes)
        {
            GradientPanel gPanel = (GradientPanel)this.Component;
            styleAttributes.Add("filter", gPanel.GetFilterString());
            base.AddDesignTimeCssAttributes(styleAttributes);
        }
    }



}