let $parent := replace(file:parent(static-base-uri()), '/scripts/bxs/', '') 
let $path := $parent || "/data/" 
return db:create("modr-cts-texts", $path, (), map { 'ftindex': true(), 'chop': false(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })