(: take JSON of a sentence-tokenized text, transform into sequence of p's and s's, numbered :)

let $f := "/home/neven/cltk/sen-ep-1-1.json"
let $json := file:read-text($f)
let $name := file:name($f)
let $text := element div {
  attribute xml:id { $name },
for $p in json-to-xml($json)//*:array/*:array[*:string]
let $n := count($p/preceding-sibling::*:array[*:string]) + 1 
return element p { 
attribute n { "p" || $n },
  for $s in $p/*:string
  let $ns := count($s/preceding-sibling::*:string) + 1
  return element s { 
  attribute n { "s" || $ns },
  normalize-space($s/string()) } }
}
return $text