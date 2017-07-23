for $t in db:open("riario_tb")/*:treebank
let $target := $t/@target
let $source := db:open("modr-riar-texts", "nikolamodr01.croala1394919.croala-lat2w.xml")//*[@n=$target]
let $newp := 
element { replace($target, '[0-9]+$', '') } {
  attribute n { $target },
for $s in $t/*:sentence
return element s {
  attribute n { $s/@id },
  for $w in $s/*:word
    let $id := $w/@id
    let $lemma := $w/@lemma
    let $ana := $w/@postag
    let $form := $w/@form
    return element w {
      attribute n { $id },
      attribute lemma { $lemma },
      attribute ana { $ana },
      data($form)
    }
}
}
order by $target
return replace node $source with $newp