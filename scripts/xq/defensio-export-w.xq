(: export a word-tokenized file :)
for $doc in db:open("modr-def-texts","nikolamodr01.croala1394999.croala-lat2w.xml")//*:TEI
return $doc