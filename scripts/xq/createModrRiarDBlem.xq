(: create a db of the lemmatized version of Riario speech :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/data/nikolamodr01/croala1394919/nikolamodr01.croala1394919.croala-lat2w.lemmata.xml') 
return db:create("modr-riar-lemm", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })