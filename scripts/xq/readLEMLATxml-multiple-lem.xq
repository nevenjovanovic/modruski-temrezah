let $p := "/home/neven/Downloads/linux_embedded/sen1-1-forms-lem.xml"
let $f := fetch:xml($p)
for $a in $f//*:Analyses[not(*:Analysis[2]) and *:Analysis/*:Lemmas[*:Lemma[2]]]
let $input := $a/*:input_worform/string()
let $lemma := $a/*:Analysis/*:Lemmas/*:Lemma
return element w {
  element form { $input } ,
  for $l in $lemma
  return element lem {
    $l/@n_id ,
    $l/@lemma/string()
  }
}