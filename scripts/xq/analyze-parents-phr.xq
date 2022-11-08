(: for phr, get parents, group by parents :)
declare function local:table($table){
element table {
  element thead {
    element tr {
       element td { "Colon" },
       element td { "Phr DB ID"},
       element td { "Parens" },
       element td { "Parentis DB ID"}
  }
  },
  $table
}
};
let $table := element tbody {
for $p in db:open("modr-riar-rhet")//*:div[@xml:id="part1"]//*:phr
let $ana := $p/@ana/string()
let $dbid := db:node-id($p)
let $parent := if ($p/../name()="phr") then $p/../@ana/string() else $p/../name()
let $parentid := db:node-id($p/..)
order by $ana
return element tr {
  element td { $ana } ,
  element td { $dbid },
  element td { $parent },
  element td { $parentid }
}
}
for $t in $table//tr
let $head := $t/td[1]
group by $head
order by count($t) descending
return element tr {
  element td { $head },
  element td { count($t) },
  element td { for $tn in $t
  return ( element span { $tn/td[3]/string() } , ": " , $tn/td[4]/string() ) }
}