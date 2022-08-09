(: index all stylistic annotations :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace modruski = "http://croala.ffzg.unizg.hr/modruski" at "../../repo/modruski.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Index stilisticus in Nicolai Modrusiensis orationem (1474)';
declare variable $content := "Display an index of stylistic annotations to Nicholas of Modruš Oratio in funere Petri Riarii (1474).";
declare variable $keywords := "Neo-Latin literature, style, stylistics, Nikola Modruški, Nicholas of Modruš, Early Modern Italy, Renaissance Latin";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("nm-stil/index-stilisticus")
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
  function page:modruskiindexstil()
{
  (: HTML template starts here :)

<html>
{ modruski:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Ad Nicolai Modrusiensis orationem in funere Petri Riarii index stilisticus; <a href="http://croala.ffzg.unizg.hr">CroALa</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a></p>
<p>Indiculus notarum stilisticarum affertur. Nexus verba annotata ostendent.</p>
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
  <td>Notae definitio</td>
	<td>Ostende locos in editione</td>
  <td>Quoties in editione</td>
  </tr>
	</thead>
  <tbody>
	{ modruski:indiculus() }
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




