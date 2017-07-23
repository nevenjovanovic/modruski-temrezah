let $f := "/home/neven/cltk/q10.json"
let $json := file:read-text($f)
for $p in json-to-xml($json)//*:array[*:string]
let $s := tokenize($p/*:string, '/')
return element tr {
  element td { 
  attribute class { "form"},
  $s[1] },
  element td { 
  attribute class { "lemma"},
  $s[2]}
}