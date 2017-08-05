(: create a db of editions of the Defensio :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/data/nikolamodr01/croala1394999/') 
return db:create("modr-def-texts", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })