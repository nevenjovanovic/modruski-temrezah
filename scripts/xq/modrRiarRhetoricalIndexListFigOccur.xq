(: for all distinct values in phr/@ana, list occurrences, both alone and in combination :)
(: node-id in @n, occurrence in span :)
declare function local:stylevalues(){
  distinct-values(
for $a in  db:open("modr-riar-rhet")//*:phr
let $list := for $item in tokenize($a/@ana/string(), " ")
return $item
return $list )
};
element table {
  element thead {
    element tr {
       element td { "Figura" },
       element td { "Quot singuli"},
       element td { "Quot" },
       element td { "Ubi et quibus complexionibus"}
  }
  },
for $fig in local:stylevalues()
let $occsingle := db:open("modr-riar-rhet")//*:phr[@ana=$fig]
let $occ := for $a in db:open("modr-riar-rhet")//*:phr[contains(@ana, $fig )]
let $id := db:node-id($a)
let $val := lower-case($a/@ana/string())
order by $val
return element span { element b { $id } , ":" , $val }
return element tr {
  element td { $fig } ,
  element td { count($occsingle) },
  element td { count($occ) },
  element td { $occ }
}
}