(: query the local lemmaBank LiLa database for a specific word :)
declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace ontolex = "http://www.w3.org/ns/lemon/ontolex#";
for $r in collection("lemmaBank")//rdf:Description
where $r/ontolex:writtenRep/string() = "existimo"
return $r/@rdf:about/string()