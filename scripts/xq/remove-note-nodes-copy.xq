copy $doc := db:open("modr-cts-texts","nikolamodr01/croala1394919/nikolamodr01.croala1394919.croala-lat1.xml")
modify delete node $doc//*:text//*:note
return $doc