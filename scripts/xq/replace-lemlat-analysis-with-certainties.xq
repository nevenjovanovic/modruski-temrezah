declare function local:transform-certs($word, $pos, $puno, $malo) {
  db:open("def-lemlat","defensio-LEMLAT-TEI-manual.xml")/*:TEI/*:text/*:body/*:ab/*:w[*:orig=$word] transform with {
  replace value of node ./*:interpGrp[$pos]/@cert with $puno ,
  for $o in ./*:interpGrp[not(position()=$pos)]/@cert
  return replace value of node $o  with $malo
}

};
let $pos := 1
let $puno := 100
let $malo := 0
let $word := "aduersati"
let $node := db:open("def-lemlat","defensio-LEMLAT-TEI-manual.xml")/*:TEI/*:text/*:body/*:ab/*:w[*:orig=$word]
let $update := local:transform-certs($word, $pos, $puno, $malo)
return replace node $node with $update