(: group phr by @ana values, tokenize combinations, include node-ids :)
let $table := element table {
for $a in  db:open("modr-riar-rhet")//*:phr
let $value := for $item in tokenize($a/@ana/string(), " ")
let $loc := db:node-id($a)
return element tr {  element td { $item } , 
element td { $loc  }
}
return $value
}
for $t in $table/tr
let $rhet := $t/td[1]
group by $rhet
order by lower-case($rhet)
return element tr { 
element td {  replace(lower-case($rhet), "#", "") } , 
element td { count($t) },
element td { $t/td[2]/string() } }