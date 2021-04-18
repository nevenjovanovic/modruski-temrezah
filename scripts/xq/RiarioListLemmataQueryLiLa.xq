declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace rdfs = "http://www.w3.org/2000/01/rdf-schema#";
declare namespace ontolex = "http://www.w3.org/ns/lemon/ontolex#";
declare namespace lila = "http://lila-erc.eu/ontologies/lila/";
(: get a list of unique lemmata :)
let $lemmauniq := (
let $lemmata := (
for $l in collection("modr-riar-lemm")//*:body//*:w
let $lem := $l/@lemma/string()
return replace(
  replace(
  replace($lem, "v", "u"), "j", "i"), "[0-9\- ]", ""))
return distinct-values($lemmata) )
(: for $n in 1 to 20 :)
for $c in $lemmauniq
let $lemmaB := collection("lemmaBank")//rdf:Description[rdfs:label[string()=$c]]
return element w { 
attribute lemma { $c } ,
for $ll in $lemmaB return ( element ref { attribute lemmaRef { $ll/@rdf:about/string() }, $c } , element POS { $ll/lila:hasPOS/@rdf:resource/string() } ) }
