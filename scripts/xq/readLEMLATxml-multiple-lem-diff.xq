let $p := "/home/neven/Downloads/linux_embedded/sen1-1-forms-lem.xml"
let $f := fetch:xml($p)
let $result := element ab {
  attribute n { file:name($p) }, 
for $a in $f//*:Analyses
let $input := $a/*:input_worform/string()
let $lemmata := $a/*:Analysis/*:Lemmas
return element w {
  if ($lemmata[2]) then 
  attribute ana { "multilem" } 
  else if ($lemmata/*:Lemma[2]) then attribute ana { "deriv"} 
  else () ,
  element orig { $input } ,
  for $l in $lemmata
  return element interpGrp {
   if ($lemmata[2]) then attribute cert { 
round( 100 div count($lemmata) , 1)
} else(),
    if ($l/*:Lemma[2]) then attribute ana { "deriv"}
    else (),
    for $ll in $l/*:Lemma return element interp { 
    attribute n { "lemlat:" || $ll/@n_id } ,
    attribute type { "lemma"},
    attribute ana { $ll/@lemma }
  }
  }
}
}
return $result