declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace rdfs = "http://www.w3.org/2000/01/rdf-schema#";
declare namespace ontolex = "http://www.w3.org/ns/lemon/ontolex#";
declare namespace lila = "http://lila-erc.eu/ontologies/lila/";
(: get a list of numbers-only lemmata :)
let $numbers := distinct-values(
for $w in db:open("modr-riar-lemm")//*:w[matches(@lemmaRef, "^[0-9]+")]
return $w/@lemmaRef/string()
)
for $n in $numbers
(: for $w in db:open("modr-riar-lemm")//*:w[@lemmaRef="106748"] :)
(: let $l := $w/@lemmaRef/string() :)
let $lila := db:open("lemmaBank")//rdf:Description[ends-with(@rdf:about, $n)]
return element res { element ri { $n } , for $l in $lila return element l { $l/@rdf:about/string() , $l/rdfs:label/string() } }