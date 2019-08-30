using System;
using System.Web.UI.WebControls;

namespace myControls
{
    /// <summary>
    /// Displays a confirmation before deleting a record
    /// </summary>
    public class DeleteButtonField : ButtonField
    {
        private string _confirmText = "Delete this record?";

        public string ConfirmText
        {
            get { return _confirmText; }
            set { _confirmText = value; }
        }

        public DeleteButtonField()
        {
            this.CommandName = "Delete";
            this.Text = "Delete";
        }

        public override void InitializeCell(DataControlFieldCell cell, DataControlCellType cellType, DataControlRowState rowState, int rowIndex)
        {
            base.InitializeCell(cell, cellType, rowState, rowIndex);
            if (cellType == DataControlCellType.DataCell)
            {
                WebControl button = (WebControl)cell.Controls[0];
                button.Attributes["onclick"] = String.Format("return confirm('{0}');", _confirmText);
            }
        }

    }
}