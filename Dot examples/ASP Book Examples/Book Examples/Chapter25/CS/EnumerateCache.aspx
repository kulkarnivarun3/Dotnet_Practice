<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    public class CacheItem
    {
        private string _key;
        private object _value;
        
        public string Key
        {
            get { return _key; }
        }

        public string Value
        {
            get { return _value.ToString(); }
        }

        public CacheItem(string key, object value)
        {
            _key = key;
            _value = value;    
        }
    }
    
    void Page_Load()
    {
        ArrayList items = new ArrayList();
        foreach (DictionaryEntry item in Cache)
            items.Add(new CacheItem(item.Key.ToString(),item.Value));
        
        grdCache.DataSource = items;
        grdCache.DataBind();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <style type="text/css">
        .grid td, .grid th
        {
            padding:5px;
        }
    </style>
    <title>Enumerate Cache</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:GridView
        id="grdCache"
        CssClass="grid"
        Runat="server" />
    
    </div>
    </form>
</body>
</html>
