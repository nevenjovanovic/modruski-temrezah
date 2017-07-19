(: delete comments in basic text version :)
let $c := db:open("modr-riar-texts","nikolamodr01.croala1394919.croala-lat1.quote.xml")/*:TEI/*:text
for $q in $c//*:abbr
let $t := normalize-space(data($q))
return replace node $q with $t