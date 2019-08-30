using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace myControls
{

    public class ArticleWithDefault : CompositeControl
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

        [TemplateContainer(typeof(ArticleWithDefault))]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public ITemplate ItemTemplate
        {
            get { return _itemTemplate; }
            set { _itemTemplate = value; }
        }

        protected override void CreateChildControls()
        {
            if (_itemTemplate == null)
                _itemTemplate = new ArticleDefaultTemplate();
            _itemTemplate.InstantiateIn(this);
        }
    }

    public class ArticleDefaultTemplate : ITemplate
    {
        public void InstantiateIn(Control container)
        {
            Label lblTitle = new Label();
            lblTitle.DataBinding += new EventHandler(lblTitle_DataBinding);

            Label lblAuthor = new Label();
            lblAuthor.DataBinding += new EventHandler(lblAuthor_DataBinding);

            Label lblContents = new Label();
            lblContents.DataBinding += new EventHandler(lblContents_DataBinding);

            container.Controls.Add(lblTitle);
            container.Controls.Add(new LiteralControl("<br />"));
            container.Controls.Add(lblAuthor);
            container.Controls.Add(new LiteralControl("<br />"));
            container.Controls.Add(lblContents);
        }

        void lblTitle_DataBinding(object sender, EventArgs e)
        {
            Label lblTitle = (Label)sender;
            ArticleWithDefault container = (ArticleWithDefault)lblTitle.NamingContainer;
            lblTitle.Text = container.Title;
        }

        void lblAuthor_DataBinding(object sender, EventArgs e)
        {
            Label lblAuthor = (Label)sender;
            ArticleWithDefault container = (ArticleWithDefault)lblAuthor.NamingContainer;
            lblAuthor.Text = container.Author;
        }

        void lblContents_DataBinding(object sender, EventArgs e)
        {
            Label lblContents = (Label)sender;
            ArticleWithDefault container = (ArticleWithDefault)lblContents.NamingContainer;
            lblContents.Text = container.Contents;
        }

    }

}
