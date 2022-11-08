(: for $w in db:open("modr-lila")//*:w[*:ref and not(*:ref[2])] :)
for $w in db:open("modr-riar-lemm")//*:w[not(@lemmaRef) and not(@ana="compositum")]
let $l := $w/@lemma/string()
let $lem := replace(
  replace(
  replace(
    replace(
      lower-case($l), "j", "i"), "v", "u"), "-", ""), "[0-9]", "")
let $lila := db:open("modr-lila")//*:w[*:ref and not(*:ref[2]) and @lemma=$lem]
return insert node $lila/*:ref/@lemmaRef into $w