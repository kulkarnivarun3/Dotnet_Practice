using System;
using System.Configuration;
using System.Drawing;

namespace AspNetUnleashed
{
    public class DesignSection : ConfigurationSection
    {
        [ConfigurationProperty("backcolor", DefaultValue = "lightblue", IsRequired = true)]
        public Color BackColor
        {
            get { return (Color)this["backcolor"]; }
            set { this["backcolor"] = value; }
        }

        [ConfigurationProperty("styleSheetUrl", DefaultValue = "~/styles/style.css", IsRequired = true)]
        [RegexStringValidator(".css$")]
        public string StyleSheetUrl
        {
            get { return (string)this["styleSheetUrl"]; }
            set { this["styleSheetUrl"] = value; }
        }

        public DesignSection(Color backcolor, string styleSheetUrl)
        {
            this.BackColor = backcolor;
            this.StyleSheetUrl = styleSheetUrl;
        }

        public DesignSection()
        {
        }
    }
}