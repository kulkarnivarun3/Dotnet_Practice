using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    public class LoginStandards : CompositeControl
    {
        private TextBox txtUserName;
        private TextBox txtPassword;

        public string UserName
        {
            get
            {
                EnsureChildControls();
                return txtUserName.Text;
            }

            set
            {
                EnsureChildControls();
                txtUserName.Text = value;
            }
        }

        public string Password
        {
            get
            {
                EnsureChildControls();
                return txtPassword.Text;
            }

            set
            {
                EnsureChildControls();
                txtPassword.Text = value;
            }
        }

        protected override void CreateChildControls()
        {
            txtUserName = new TextBox();
            txtUserName.ID = "txtUserName";
            this.Controls.Add(txtUserName);

            txtPassword = new TextBox();
            txtPassword.ID = "txtPassword";
            txtPassword.TextMode = TextBoxMode.Password;
            this.Controls.Add(txtPassword);
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute("float", "left");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.AddAttribute(HtmlTextWriterAttribute.For, txtUserName.ClientID);
            writer.RenderBeginTag(HtmlTextWriterTag.Label);
            writer.Write("User Name:");
            writer.RenderEndTag();
            writer.RenderEndTag();

            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.AddAttribute(HtmlTextWriterAttribute.For, txtPassword.ClientID);
            writer.RenderBeginTag(HtmlTextWriterTag.Label);
            writer.Write("Password:");
            writer.RenderEndTag();
            writer.RenderEndTag();
            writer.RenderEndTag();

            writer.AddStyleAttribute("float", "left");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            txtUserName.RenderControl(writer);
            writer.RenderEndTag();

            writer.AddStyleAttribute(HtmlTextWriterStyle.Padding, "3px");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            txtPassword.RenderControl(writer);
            writer.RenderEndTag();
            writer.RenderEndTag();

            writer.Write("<br style='clear:left' />");
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div;
            }
        }

    }
}