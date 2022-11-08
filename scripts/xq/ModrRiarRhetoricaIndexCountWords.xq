(: get phr, @ana values and number of words :)
let $table := element table {
for $a in  db:open("modr-riar-rhet")//*:phr
let $ana := $a/@ana
let $id := db:node-id($a)
let $w := $a//*:w[not(*:w)]
return element tr {
  element td { lower-case($ana/string()) },
  element td { $id },
  element td { count($w) }
}
}
return $table