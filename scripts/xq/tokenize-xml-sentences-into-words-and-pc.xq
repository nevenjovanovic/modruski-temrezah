(: tokenize string ending with punctuation into characters and punctuation :)
declare function local:tokenize-words-pc($token){
  for $part in analyze-string($token, '\w+')/*
   return  if ($part/name()="fn:match") then element w { $part/string()} else element pc { $part/string()}
};

(: for a node with @n attribute, copy name and attribute, add different content :)
declare function local:copy-node($node, $content) {
  let $name := $node/name()
  let $n := $node/@*
  return element { $name } {
    $n ,
    $content
  }
};

let $f := "/home/neven/Documents/documents/latinisti/nimira/nimira-Q12636396.sermo-de-passione.croala-lat02-sententiae.xml"
let $xml := fetch:xml($f)
for $d in $xml//*:div[*:p]
return local:copy-node($d,
for $p in $d/*:p
return local:copy-node($p ,
   for $s in $p/*:seg
   return local:copy-node( $s ,
   let $words_tokenized := tokenize($s/string(), '\s')
   for $w in $words_tokenized return
   local:tokenize-words-pc($w)
  )
)
)