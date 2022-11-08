for $w in db:open("modr-riar-lemm")//*:w[not(@lemmaRef) and not(@ana="compositum")]
let $l := $w/@lemma/string()
let $lem := replace(
  replace(
  replace(
    replace(
      lower-case($l), "j", "i"), "v", "u"), "-", ""), "[0-9]", "")
let $lila := db:open("modr-lila")//*:w[*:var and *:var/*:POS="http://lila-erc.eu/ontologies/lila/proper_noun" and *:var/*:POS="http://lila-erc.eu/ontologies/lila/noun" and @lemma=$lem]
where $lila/*:var
return insert node $lila/*:var[*:POS="http://lila-erc.eu/ontologies/lila/noun"]/*:ref/@lemmaRef into $w