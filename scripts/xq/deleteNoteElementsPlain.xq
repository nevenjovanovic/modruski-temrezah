(: delete comments in basic text version :)
let $c := db:open("modr-riar-texts","nikolamodr01.croala1394919.croala-lat1.quote.xml")/*:TEI/*:text
for $q in $c//*:note
return delete node $q