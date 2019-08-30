using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace myControls
{
    /// <summary>
    /// Enables you to display a long text field
    /// </summary>
    public class LongTextField : BoundField
    {
        private Unit _width = new Unit("250px");
        private Unit _height = new Unit("60px");

        /// <summary>
        /// The Width of the field
        /// </summary>
        public Unit Width
        {
            get { return _width; }
            set { _width = value; }
        }

        /// <summary>
        /// The Height of the field
        /// </summary>
        public Unit Height
        {
            get { return _height; }
            set { _height = value; }
        }

        /// <summary>
        /// Builds the contents of the field
        /// </summary>
        protected override void InitializeDataCell(DataControlFieldCell cell, DataControlRowState rowState)
        {
            // If not editing, show in scrolling div
            if ((rowState & DataControlRowState.Edit) == 0)
            {
                HtmlGenericControl div = new HtmlGenericControl("div");
                div.Attributes["class"] = "longTextField";
                div.Style[HtmlTextWriterStyle.Width] = _width.ToString();
                div.Style[HtmlTextWriterStyle.Height] = _height.ToString();
                div.Style[HtmlTextWriterStyle.Overflow] = "auto";

                div.DataBinding += new EventHandler(div_DataBinding);

                cell.Controls.Add(div);
            }
            else
            {
                TextBox txtEdit = new TextBox();
                txtEdit.TextMode = TextBoxMode.MultiLine;
                txtEdit.Width = _width;
                txtEdit.Height = _height;

                txtEdit.DataBinding += new EventHandler(txtEdit_DataBinding);

                cell.Controls.Add(txtEdit);
            }
        }

        /// <summary>
        /// Called when databound in display mode
        /// </summary>
        void div_DataBinding(object s, EventArgs e)
        {
            HtmlGenericControl div = (HtmlGenericControl)s;

            // Get the field value
            Object value = this.GetValue(div.NamingContainer);

            // Assign the formatted value
            div.InnerText = this.FormatDataValue(value, this.HtmlEncode);
        }

        /// <summary>
        /// Called when databound in edit mode
        /// </summary>
        void txtEdit_DataBinding(object s, EventArgs e)
        {
            TextBox txtEdit = (TextBox)s;

            // Get the field value
            Object value = this.GetValue(txtEdit.NamingContainer);

            // Assign the formatted value
            txtEdit.Text = this.FormatDataValue(value, this.HtmlEncode);
        }

    }
}