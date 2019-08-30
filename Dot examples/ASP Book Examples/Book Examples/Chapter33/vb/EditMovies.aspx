<%@ Page Language="vb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Movies</title>
    <script type="text/javascript">
    
      function pageLoad() 
      {
        $addHandler($get("btnAdd"), "click", addMovie); 
        bindMovies();
      }
    
      function bindMovies()
      {
        MovieService.SelectAll(selectAllSuccess);      
      }
    
      function addMovie()
      {
        var movieToAdd = 
            {
                Title: $get("txtTitle").value,
                Director: $get("txtDirector").value
            };
        
        MovieService.Insert(movieToAdd, addMovieSuccess);
      }
        
      function addMovieSuccess()
      {
        bindMovies();
      }  

      function selectAllSuccess(results)
      {
        var sb = new Sys.StringBuilder()
        var movie;
        var row;
        for (var i=0;i < results.length; i++)
        {
            movie = results[i];
            row = String.format("{0} directed by {1}<br />", movie.Title, movie.Director);
            sb.appendLine(row);
        }
        $get("divMovies").innerHTML = sb.toString();
      }
    </script>
</head>
<body>
<form runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
<Services>
    <asp:ServiceReference InlineScript="true" Path="~/Services/MovieService.asmx" />
</Services>
</asp:ScriptManager>

<fieldset>
<legend>Add Movie</legend>

<label for="txtTitle">Title:</label>
<input id="txtTitle" />

<br /><br />

<label for="txtTitle">Director:</label>
<input id="txtDirector" />

<br /><br />

<input id="btnAdd" type="button" value="Add Movie" />

</fieldset>

<div id="divMovies"></div>

</form>
</body>
</html>
