(: for a test cts get value, next and prev :)
(: format result as bootstrap card :)
declare variable $db := ( "modr-ed" );
declare variable $ctsdb := ( "modr-ed-cts-nodes" );
(: URL for function page :)
declare variable $croala-sub := ( "https://croala.ffzg.unizg.hr/basex/modr-ed/cts/doc/" );
(: format link for next and prev :)
declare function local:hrefsub($ctsurn){
  element a {
    attribute class { "card-link" } , 
    attribute href { $croala-sub || $ctsurn },
    $ctsurn
  }
};
(: test value :)
let $subcts := "urn:cts:croala:nicolausmodrusiensis.oratioriario.croala-ldlt.verba-stilistica-lila-lemmata:body[1]div[1]p[2]"
let $newsubcts := replace(replace($subcts, "\]", "]/"), "/$", "")
for $n in db:open($ctsdb)//tr[td=$newsubcts]
let $id := xs:integer($n/td[2]/string())
let $prevlink := $n/preceding-sibling::tr[1]/td[1]/string()
let $nextlink := $n/following-sibling::tr[1]/td[2]/string()
let $prev := xs:integer($n/preceding-sibling::tr[1]/td[2]/string())
let $next := xs:integer($n/following-sibling::tr[1]/td[2]/string())
return element div { 
attribute class { "card"},
element div {
  attribute class { "card-header"},
  element pre {
    db:open-id($db, $id)
  }
},

element div {
  attribute class { "card-body"},
element p { attribute class { "card-text"},
"URN prior: ",
local:hrefsub($prevlink)
},
element p { attribute class { "card-text"} , 
element pre { db:open-id($db, $prev) } },
element p { attribute class { "card-text"},
"URN posterior: ",
local:hrefsub($nextlink)
},
element p { attribute class { "card-text"}, 
element pre { db:open-id($db, $next) } }
}
}