(: create a db of the Riario speech with rhetorical annotations :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/data/nikolamodr01/croala1394919/nikolamodr01.croala1394919.croala-lat3w.rhetorica.xml') 
return db:create("modr-riar-rhet", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })