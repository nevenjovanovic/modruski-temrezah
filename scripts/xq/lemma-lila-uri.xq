(:create a markdown pair of a lemma and its lila URI :)
let $words :=
for $w in collection("modr-riar-lemm")//*:w[@lemmaRef]
let $lila := $w/@lemmaRef/string()
let $lem := $w/@lemma/string()
return "[" || $lem || "](https://lila-erc.eu/data/id/lemma/" || $lila || ")  "
return for $d in distinct-values($words)
order by $d
return $d