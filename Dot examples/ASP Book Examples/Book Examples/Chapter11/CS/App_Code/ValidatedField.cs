using System;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{
    /// <summary>
    /// Adds RequiredFieldValidator and CompareValidator
    /// to BoundField
    /// </summary>
    public class ValidatedField : BoundField
    {
        private ValidationDataType _validationDataType = ValidationDataType.String;

        public ValidationDataType ValidationDataType
        {
            get { return _validationDataType; }
            set { _validationDataType = value; }
        }

        /// <summary>
        /// Get value from TextBox
        /// </summary>
        public override void ExtractValuesFromCell(IOrderedDictionary dictionary, DataControlFieldCell cell, DataControlRowState rowState, bool includeReadOnly)
        {
            EditContainer edit = (EditContainer)cell.Controls[0];
            if (dictionary.Contains(DataField))
                dictionary[DataField] = edit.Text;
            else
                dictionary.Add(DataField, edit.Text);
        }

        /// <summary>
        /// Called when field is bound to data source
        /// </summary>
        protected override void OnDataBindField(object sender, EventArgs e)
        {
            Control source = (Control)sender;

            // Get the field value
            Object value = this.GetValue(source.NamingContainer);

            // If the control is a table cell, display the text
            if (source is DataControlFieldCell)
            {
                string formattedValue = this.FormatDataValue(value, this.HtmlEncode);
                if (formattedValue == String.Empty)
                    formattedValue = "&nbsp;";
                ((DataControlFieldCell)source).Text = formattedValue;
            }

            // If the control is an editor, display the editor
            if (source is EditContainer)
            {
                string formattedValue = string.Empty;
                switch (_validationDataType)
                {
                    case ValidationDataType.Date:
                        DateTime date = (DateTime)value;
                        formattedValue = date.ToShortDateString();
                        break;
                    case ValidationDataType.Currency:
                        Decimal dec = (Decimal)value;
                        formattedValue = dec.ToString("F");
                        break;
                    default:
                        formattedValue = value.ToString();
                        break;
                }
                ((EditContainer)source).Text = formattedValue;
            }
        }

        /// <summary>
        /// Build the field 
        /// </summary>
        protected override void InitializeDataCell(DataControlFieldCell cell, DataControlRowState rowState)
        {
            if ((rowState & DataControlRowState.Edit) == 0)
            {
                if (DataField.Length != 0)
                {
                    cell.DataBinding += new EventHandler(this.OnDataBindField);
                }
            }
            else
            {
                EditContainer editor = new EditContainer(DataField, _validationDataType);
                editor.DataBinding += new EventHandler(this.OnDataBindField);
                cell.Controls.Add(editor);
            }
        }
    }

    /// <summary>
    /// This control is added to the field
    /// </summary>
    public class EditContainer : Control, INamingContainer
    {
        private string _dataField;
        private ValidationDataType _validationDataType;

        private TextBox _txtEdit;
        private RequiredFieldValidator _valReq;
        private CompareValidator _valCompare;

        public EditContainer(string dataField, ValidationDataType validationDataType)
        {
            _dataField = dataField;
            _validationDataType = validationDataType;
        }

        /// <summary>
        /// Expose the TextBox control's Text Property
        /// </summary>
        public string Text
        {
            get
            {
                EnsureChildControls();
                return _txtEdit.Text;
            }
            set
            {
                EnsureChildControls();
                _txtEdit.Text = value;
            }
        }

        /// <summary>
        /// Add TextBox, RequiredFieldValidator, and
        /// CompareValidator
        /// </summary>
        protected override void CreateChildControls()
        {
            // Add the textbox
            _txtEdit = new TextBox();
            _txtEdit.ID = "txtEdit";
            Controls.Add(_txtEdit);

            // Add a RequiredFieldValidator control
            _valReq = new RequiredFieldValidator();
            _valReq.Display = ValidatorDisplay.Dynamic;
            _valReq.Text = "(required)";
            _valReq.ControlToValidate = _txtEdit.ID;
            Controls.Add(_valReq);

            // Add a CompareValidator control
            _valCompare = new CompareValidator();
            _valCompare.Display = ValidatorDisplay.Dynamic;
            _valCompare.Operator = ValidationCompareOperator.DataTypeCheck;
            _valCompare.Type = _validationDataType;
            _valCompare.Text = "(invalid)";
            _valCompare.ControlToValidate = _txtEdit.ID;
            Controls.Add(_valCompare);
        }
    }
}
