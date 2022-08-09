(: Modrusiensis rhetorical index :)
(: List locations of all phr elements :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace nm = "http://croala.ffzg.unizg.hr/nm" at "../../repo/modr.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Nicolai Modrusiensis oratio (1474): stilistica';
declare variable $content := "Display count of stylistic annotations.";
declare variable $keywords := "Renaissance Humanism, Neo-Latin, funeral oration, stylistic analysis";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("modr-rhet-index")
  %output:method(
  "html"
)
  %output:omit-xml-declaration(
  "yes"
)

  function page:nicmodrlistphr()
{
  (: HTML template starts here :)

<html>
<body text="#000000">
<p>Functio nominatur: {rest:uri()}.</p>
<p>{ nm:phrinfo("modr-riar-rhet") }</p>

</body>
</html>
};

return


