using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design;
using System.ComponentModel;
using System.ComponentModel.Design;

namespace myControls
{
    [Designer(typeof(SmartImageDesigner))]
    public class SmartImage : WebControl
    {
        string _imageUrl;
        string _alternateText;
        int _rotation = 0;
        bool _mirror = false;

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

        public int Rotation
        {
            get { return _rotation; }
            set { _rotation = value; }
        }

        public bool Mirror
        {
            get { return _mirror; }
            set { _mirror = value; }
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Img;
            }
        }

        private string GetFilterString()
        {
            string _mirrorValue = "0";
            if (_mirror)
                _mirrorValue = "1";

            return String.Format("progid:DXImageTransform.Microsoft.BasicImage(Rotation={0},Mirror={1})", _rotation, _mirrorValue);
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer)
        {
            writer.AddStyleAttribute(HtmlTextWriterStyle.Filter, this.GetFilterString());
            writer.AddAttribute(HtmlTextWriterAttribute.Src, _imageUrl);
            writer.AddAttribute(HtmlTextWriterAttribute.Alt, _alternateText);


            base.AddAttributesToRender(writer);
        }
    }

    public class SmartImageDesigner : ControlDesigner
    {
        public override DesignerActionListCollection ActionLists
        {
            get
            {
                DesignerActionListCollection actionLists = new DesignerActionListCollection();
                actionLists.AddRange(base.ActionLists);
                actionLists.Add(new SmartImageActionList(this));
                return actionLists;
            }
        }
    }

    public class SmartImageActionList : DesignerActionList
    {

        private DesignerActionItemCollection items;
        private SmartImageDesigner _parent;

        public SmartImageActionList(SmartImageDesigner parent)
            : base(parent.Component)
        {
            _parent = parent;
        }

        public void Rotate()
        {
            TransactedChangeCallback toCall = new TransactedChangeCallback(DoRotate);
            ControlDesigner.InvokeTransactedChange(this.Component, toCall, "Rotate", "Rotate image 90 degrees");
        }

        public void Mirror()
        {
            TransactedChangeCallback toCall = new TransactedChangeCallback(DoMirror);
            ControlDesigner.InvokeTransactedChange(this.Component, toCall, "Mirror", "Mirror Image");
        }

        public override DesignerActionItemCollection GetSortedActionItems()
        {
            if (items == null)
            {
                items = new DesignerActionItemCollection();
                items.Add(new DesignerActionMethodItem(this, "Rotate", "Rotate Image", true));
                items.Add(new DesignerActionMethodItem(this, "Mirror", "Mirror Image", true));
            }
            return items;
        }

        public bool DoRotate(object arg)
        {
            SmartImage img = (SmartImage)this.Component;
            img.Rotation += 1;
            if (img.Rotation > 3)
                img.Rotation = 0;
            _parent.UpdateDesignTimeHtml();
            return true;
        }

        public bool DoMirror(object arg)
        {
            SmartImage img = (SmartImage)this.Component;
            img.Mirror = !img.Mirror;
            _parent.UpdateDesignTimeHtml();
            return true;
        }
    }
}