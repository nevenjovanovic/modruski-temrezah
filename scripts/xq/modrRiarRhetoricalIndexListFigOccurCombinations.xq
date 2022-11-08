(: for all distinct values in phr/@ana, list occurrences, only in combination :)
(: node-id in @n, occurrence in span :)
declare function local:stylevalues(){
  distinct-values(
for $a in  db:open("modr-riar-rhet")//*:phr
let $list := for $item in tokenize($a/@ana/string(), " ")
return $item
return $list )
};
declare function local:table($table){
element table {
  element thead {
    element tr {
       element td { "Figura" },
       element td { "Quot"},
       element td { "Quot complexiones" },
       element td { "Ubi et quibus complexionibus"}
  }
  },
  $table
}
};
let $table := element tbody {
for $fig in local:stylevalues()
let $total := count(db:open("modr-riar-rhet")//*:phr[contains(@ana, $fig )])
let $count := count(db:open("modr-riar-rhet")//*:phr[contains(@ana, " ") and contains(@ana, $fig )])
let $occ := for $a in db:open("modr-riar-rhet")//*:phr[contains(@ana, " ") and contains(@ana, $fig )]
let $id := db:node-id($a)
let $val := lower-case($a/@ana/string())
order by $val
return (element b { $id } , ":" , $val , element br {} )
order by $count descending
return element tr {
  element td { $fig } ,
  element td { $total },
  element td { $count },
  element td { $occ }
}
}
return local:table($table)