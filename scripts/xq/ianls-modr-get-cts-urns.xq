(: for a document return all available CTS URNs, with a preview of text in the nodes :)
(: create CTS URN from a path of node :)
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $url := ( "https://croala.ffzg.unizg.hr/basex/modr-ed/cts/urn:cts:croala:nicolausmodrusiensis.oratioriario.croala-lat07-ed-gensberg" );
declare variable $db := ( "modr-ed" );
declare variable $croala-sub := ( "https://croala.ffzg.unizg.hr/basex/modr-ed/cts-sub/" );
declare function local:hrefsub($ctsurn){
  element a {
    attribute class { "card-link" } , 
    attribute href { $croala-sub || $ctsurn },
    $ctsurn
  }
};
declare function local:preview($textpreview){
  if ($textpreview[2]) 
then string-join($textpreview[position() < 6], " ") || "..."
else $textpreview
};
declare function local:cardtext($text){
  element p { 
attribute class { "card-text" } , 
$text
 }
};
let $ctsurn := substring-after($url, "/modr-ed/cts/") || ":"
for $resource in db:open($db)//tei:TEI/tei:text[@xml:base=$ctsurn]//*[name()]
let $textpreview := tokenize(normalize-space($resource/string()), " ")
let $attribs := string-join($resource/@*/string() , "; ")
let $which := replace(substring-after(path($resource),"/Q{http://www.tei-c.org/ns/1.0}TEI[1]/Q{http://www.tei-c.org/ns/1.0}text[1]/"), "Q\{http://www.tei-c.org/ns/1.0\}", "")
let $docurn := $ctsurn || $which
return element div { 
attribute class { "card"},
element div {
  attribute class { "card-body"},

local:hrefsub($docurn) ,
local:cardtext($which),
local:cardtext(local:preview($textpreview)),
local:cardtext($attribs)

}
}