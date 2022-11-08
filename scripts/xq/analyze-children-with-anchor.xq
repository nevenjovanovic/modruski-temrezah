(: for phr, get children; use anchors to group by :)
declare function local:table($table){
element table {
  element thead {
    element tr {
       element td { "Figura" },
       element td { "Quoties"},
        element td { "Filii"}
  }
  },
  $table
}
};
let $table := element tbody {
for $p in db:open("modr-riar-rhet")//*:div[@xml:id="part1"]//*:anchor
let $ana := $p/@ana/string()
let $parent := $p/..
let $id := db:node-id($parent)
let $child := if ($parent/*:phr) then $parent/*:phr/@ana/string() else "0"
group by $ana
order by count($p) descending
return element tr {
  element td { $ana } ,
  element td { count($p) },
  element td {
    for $c in $child return element span { $c }
  }
}
}
return local:table($table)