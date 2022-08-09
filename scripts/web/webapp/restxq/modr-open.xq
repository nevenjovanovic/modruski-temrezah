(: Modrusiensis open node in db :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace nm = "http://croala.ffzg.unizg.hr/nm" at "../../repo/modr.xqm";

declare namespace page = 'http://basex.org/examples/web-page';
declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare variable $title := 'Nicolai Modrusiensis oratio (1474): sectio';
declare variable $content := "Display a section from the edition.";
declare variable $keywords := "Renaissance Humanism, Neo-Latin, funeral oration, Pietro Riario, digital critical edition";

(:~
 : This function returns an XML response message.
 : @param $world  string to be included in the response
 : @return response element 
 :)
declare
    %rest:path("nicolausmodrusiensis.oratioriario.croala-ldlt/{$node}")
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
  %rest:GET
  function page:opennode($node)
{
  (: HTML template starts here :)

<html>
{ nm:htmlheadserver($title, $content, $keywords) }

<body>
<div class="header">
    <ul class="nav nav-pills pull-right">
    </ul>
    <h3 class="text-muted"> </h3>
  </div>
<div class="container">
<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span> Nicolai Modrusiensis oratio in funere Petri (Riarii, 1474): nodus</h1>

<p><a href="http://croala.ffzg.unizg.hr">CroALa</a>, { current-date() }. Nodus {$node} in collectione {$nm:db}.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="container-fluid">
<h2><span class="glyphicon glyphicon-leaf" aria-hidden="true"></span> Nodus {$node} in documento {nm:filenode(db:path(db:open-id($nm:db,$node)))}</h2>

<hr/>
<blockquote class="croalatext">
    { db:open-id($nm:db,$node) }
</blockquote>
     <p/>
     </div>
<hr/>

{ nm:footerserver() }
</div>
</body>
</html>
};

return
