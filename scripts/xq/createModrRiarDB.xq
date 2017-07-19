(: create a db of editions of the Riario speech :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/data/nikolamodr01/croala1394919/') 
return db:create("modr-riar-texts", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })