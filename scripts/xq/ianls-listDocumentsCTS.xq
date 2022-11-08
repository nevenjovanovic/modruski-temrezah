(: list CTS URNs of docs in db modr-ed for the digital scholarly edition of Nicolaus Modrusiensis, Oratio in funere Petri (1474) :)
declare variable $db-cts := ( "modr-ed" );
declare variable $croala-cts := ( "https://croala.ffzg.unizg.hr/basex/modr-ed/cts/" );
declare function local:removecolon($urn){
  if (ends-with($urn, ":")) then replace($urn, ":$", "")
  else()
};
declare function local:hrefcard($ctsurn){
  element a {
    attribute class { "card-link" } , 
    attribute href { $croala-cts || $ctsurn },
    $ctsurn
  }
};
for $doc in db:open($db-cts)//*:TEI
let $ctsurn := local:hrefcard( local:removecolon($doc//*:text/@xml:base/string()) )
let $abstract := normalize-space($doc//*:teiHeader/*:profileDesc/*:abstract/*:p/string())
return element div {
  attribute class { "card" } , 
  element div { 
  attribute class { "card-body" } , 
  $ctsurn ,
  element p { 
  attribute class { "card-text" } , $abstract } }
}