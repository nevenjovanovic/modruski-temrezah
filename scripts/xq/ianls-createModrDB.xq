(: create db modr-ed for the digital scholarly edition of Nicolaus Modrusiensis, Oratio in funere Petri (1474) :)
let $parent := replace(file:parent(static-base-uri()), '/scripts/xq/', '') 
let $path := $parent || "/data/" 
return db:create("modr-ed", $path, (), map { 'ftindex': true(), 'chop': false(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })