using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{

    public class Article : CompositeControl
    {

        private string _title;
        private string _author;
        private string _contents;

        private ITemplate _itemTemplate;

        public string Title
        {
            get { return _title; }
            set { _title = value; }
        }

        public string Author
        {
            get { return _author; }
            set { _author = value; }
        }

        public string Contents
        {
            get { return _contents; }
            set { _contents = value; }
        }

        [TemplateContainer(typeof(Article))]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate ItemTemplate
        {
            get { return _itemTemplate; }
            set { _itemTemplate = value; }
        }

        protected override void CreateChildControls()
        {
            _itemTemplate.InstantiateIn(this);
        }
    }

}
