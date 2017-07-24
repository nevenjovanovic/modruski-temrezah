let $p := "/home/neven/Downloads/linux_embedded/sen1-1-forms-lem.xml"
let $f := fetch:xml($p)
for $a in $f//*:Analyses[not(*:Analysis[2]) and *:Analysis/*:Lemmas[not(*:Lemma[2])]]
let $input := $a/*:input_worform/string()
let $lemma := $a/*:Analysis/*:Lemmas/*:Lemma/@lemma/string()
let $lemma_id := $a/*:Analysis/*:Lemmas/*:Lemma/@n_id
order by $lemma
return element w {
  $lemma_id ,
  $input ,
  $lemma
}