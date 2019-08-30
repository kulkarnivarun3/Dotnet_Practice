using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace myControls
{
    public class NewsRotator : WebControl
    {

        public static string GetNews(HttpContext context)
        {
            List<String> news = new List<string>();
            news.Add("Martians attack!");
            news.Add("Moon collides with earth!");
            news.Add("Life on Jupiter!");

            Random rnd = new Random();
            return news[rnd.Next(news.Count)];
        }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            Context.Response.WriteSubstitution(GetNews);
        }

    }
}