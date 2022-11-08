(: for anchor, get phr parent id; group by anchor :)
declare function local:table($table){
element table {
  element thead {
    element tr {
       element td { "Figura" },
       element td { "Quoties"},
       element td { "Coli DB ID"}
  }
  },
  $table
}
};
let $table := element tbody {
for $p in db:open("modr-riar-rhet")//*:div[@xml:id="part1"]//*:anchor
let $ana := $p/@ana/string()
let $id := db:node-id($p)
let $parent-id := db:node-id($p/..)
let $parent-ana := $p/../@ana/string()
group by $ana
order by count($p) descending
return element tr {
  element td { $ana } ,
  element td { count($p) },
  element td { $parent-id },
  element td {
    for $pr in $parent-ana return element span { $pr }
  }
}
}
return $table