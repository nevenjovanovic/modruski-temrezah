(: Modrusiensis rhetorical index :)
(: List locations of all phr elements :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace nm = "http://croala.ffzg.unizg.hr/nm" at "../../repo/modr.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Nicolai Modrusiensis oratio (1474): tabula contentorum';
declare variable $content := "Display table of contents.";
declare variable $keywords := "Renaissance Humanism, Neo-Latin, funeral oration, Pietro Riario";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("modr-tabula")
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


  function page:nicmodrtabula()
{
  (: HTML template starts here :)

<html>
{ nm:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<p>Functio nominatur: {rest:uri()}.</p>

<div class="container-fluid">
<blockquote class="croala">
	<div class="table-responsive">

  <!-- function here -->
{ nm:table(("Argumentum", "Paragraphus", "URN indiculus"), nm:tabulaorationis()) }
</div>
</blockquote>
</div>
</body>
</html>
};

return


