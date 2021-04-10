declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace ontolex = "http://www.w3.org/ns/lemon/ontolex#";
(: get a list of unique lemmata :)
let $lemmauniq := (
let $lemmata := (
for $l in collection("modr-riar-lemm")//*:body//*:w
let $lem := $l/@lemma/string()
return replace(replace($lem, "v", "u"), "j", "i") )
return distinct-values($lemmata) )
(: remove number at the end :)
let $querylist := (
for $lu in $lemmauniq
return if (matches($lu , "\d$")) then substring($lu, 1, string-length($lu) - 1)
else $lu )
for $n in 101 to 1000
for $q in $querylist[$n]
let $lemmaB := collection("lemmaBank")//rdf:Description[ontolex:writtenRep[string()=$q]]
return element w { for $ll in $lemmaB/@*:about/string() return  substring-after($ll, "/lemma/") , $q }
