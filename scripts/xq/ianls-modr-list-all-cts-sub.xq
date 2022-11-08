(: for a test cts document list all available CTS URNs :)
(: format result as bootstrap card :)
declare variable $db := ( "modr-ed" );
declare variable $ctsdb := ( "modr-ed-cts-nodes" );
(: URL for function page :)
declare variable $croala-sub := ( "https://croala.ffzg.unizg.hr/basex/modr-ed/cts/" );
(: format link for CTS URN :)
declare function local:hrefsub($ctsurn){
  element a {
    attribute class { "card-link" } , 
    attribute href { $croala-sub || $ctsurn },
    $ctsurn
  }
};
(: test value :)
let $subcts := "urn:cts:croala:nicolausmodrusiensis.oratioriario.croala-lat.verba-argumentum"
for $n in db:open($ctsdb)//tr[starts-with(td[1], $subcts)]
let $id := $n/td[1]/string()

return element div { 
attribute class { "card"},
element div {
  attribute class { "card-header"},
  element pre {
    $id
  }
}


}