element table {
  element thead {
    element tr {
       element td { "Paragraphus" },
       element td { "Para DB ID"},
       element td { "Quot sententiae" },
       element td { "Quot verba"},
       element td { "Quot cola stylistica"}
  }
  },
for $p in db:open("modr-riar-rhet")//*:div[@xml:id="part1"]/*:p
let $id := $p/@xml:id/string() || "." || $p/@n/string()
let $dbid := db:node-id($p)
let $s := count($p/*:s)
let $w := count($p//*:w)
let $phr := count($p//*:phr)
return element tr {
  element td { $id } ,
  element td { $dbid },
  element td { $s },
  element td { $w },
  element td { $phr }
}
}