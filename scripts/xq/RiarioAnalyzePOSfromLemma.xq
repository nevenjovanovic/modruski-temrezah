element table { 
element thead {
element tr { 
element td { "POS" } ,
element td { "Tokens" } ,
element td { "Lemmata" } ,
element td { "List of lemmata" }
 }
} ,
for $w in db:open("modr-riar-lemm")//*:w[@lemmaRef]
let $g := substring($w/@ana, 1, 1)
group by $g
return element tr {
element td { $g } , 
element td { count($w) } , 
element td { count(distinct-values($w/@lemmaRef/string())) } , 
element td {
let $lemmata := element td {
for $n in distinct-values($w/@lemmaRef/string())
return element a { attribute href { $n } ,
distinct-values(
  for $w2 in db:open("modr-riar-lemm")//*:w[@lemmaRef=$n]
return $w2/@lemma/string()
) } } 
for $ll in $lemmata/a
order by $ll/string()
return $ll }
}
}