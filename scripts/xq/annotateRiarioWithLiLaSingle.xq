for $l in db:open("riar-lila2")//*:w[*:ref and not(*:ref[2])]
let $lem := $l/@lemma/string()
let $lref := $l/*:ref/@lemmaRef
for $rw in db:open("modr-riar-lemm")//*:w[not(@lemmaRef) and replace(replace(replace(@lemma, "v", "u"), "j", "i"), "[1-9]", "")=$lem]
return insert node $lref into $rw
(: return $rw :)