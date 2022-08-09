(: retrieve all nodes for a given term using a node-id :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace modruski = "http://croala.ffzg.unizg.hr/modruski" at "../../repo/modruski.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Ubi occurrit nota in Oratione in funere Petri cardinalis S. Sixti (1474)';
declare variable $content := "Retrieve all occurrences of a term from stylistically annotated XML DB.";
declare variable $keywords := "Neo-Latin literature, Nikola Modruški, Nicholas of Modruš, Early Modern Italy, Renaissance Latin, stylistics";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("nm-stil/terminus/{$term}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)
  function page:modruskiterm($term)
{
  (: HTML template starts here :)

<html>
{ modruski:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Loci annotati in Oratione in funere Petri (1474): <a href="http://croala.ffzg.unizg.hr">CroALa</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a></p>
<p>In quibus locis occurrit nota in oratione Nicolai Modrussiensis in funere Petri, cardinalis S. Sixti (a. 1474).</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{croala:infodb('modr-riar-stil')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	<div class="table-responsive">
<table class="table-striped  table-hover table-centered">
	<thead>
	<tr>
  <td>Notae ID</td>
  <td>Annotatio stilistica</td>
	<td>Textus</td>
  </tr>
	</thead>
  <tbody>
  
	{ modruski:getallnodes($term) }
  
  </tbody>
  </table>
  
     </div>
</blockquote>
     <p/>
     </div>
<hr/>
{ modruski:footerserver() }

</body>
</html>
};

return




