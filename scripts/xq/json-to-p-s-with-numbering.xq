let $f := "/home/neven/Repos/modruski-temrezah/json/modr-sent.json"
let $json := file:read-text($f)
for $p in json-to-xml($json)//*:array/*:array
let $n := count($p/preceding-sibling::*:array) + 1 
return element p { 
attribute n { "p" || $n },
  for $s in $p/*:string
  let $ns := count($s/preceding-sibling::*:string) + 1
  return element s { 
  attribute n { "s" || $ns },
  $s/string() } }