(: for an individual CTS URN, list available information, with previous and next :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace modruski = "http://croala.ffzg.unizg.hr/modruski" at "../../repo/modruski.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'CTS inscriptio singula in documento ad Nicolai Modrusiensis orationem (1474) pertinenti';
declare variable $content := "Display an individual CTS URN available in a single document from the critical digital edition of Nicholas of Modruš Oratio in funere Petri Riarii (1474), with previous and next nodes.";
declare variable $keywords := "Neo-Latin literature, digital edition, Nikola Modruški, Nicholas of Modruš, Early Modern Italy, Renaissance Latin, CTS, CTS URN";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("modr-ed/cts/doc/{$urn}")
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
  function page:modruskidisplayctsindoc($urn)
{
  (: HTML template starts here :)

<html>
{ modruski:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Inscriptio CTS URN {$urn} in documento ad Nicolai Modrusiensis orationem in funere Petri Riarii pertinenti; <a href="http://croala.ffzg.unizg.hr">CroALa</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a></p>
<p>Inscriptio affertur cum lectione, notis, URN priore et posteriore.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{croala:infodb('modr-ed')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">

	{ modruski:displayctsdocurn($urn) }

</blockquote>
     <p/>
     </div>
<hr/>
{ modruski:footerserver() }

</body>
</html>
};

return
