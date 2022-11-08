(:create a markdown row of a lemma, num of occurrences, and its lila URI :)
let $words :=
for $w in collection("modr-riar-lemm")//*:w[@lemmaRef]
let $lila := $w/@lemmaRef/string()
group by $lila
order by count($w) descending
return if (starts-with($lila, "http://")) then "| " || distinct-values($w/@lemma/string()) || " | [" || substring-after($lila, "http://lila-erc.eu/data/id/") || "](" || $lila  || ")  | " || count($w) || "|"
else  "| " || distinct-values($w/@lemma/string()) || " | [lemma/" || $lila || "](" ||  "http://lila-erc.eu/data/id/lemma/" || $lila  || ")  | " || count($w) || "|"
return $words