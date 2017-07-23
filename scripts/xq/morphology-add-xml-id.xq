let $paths := (
for $t in db:open("riario_tb")/*:treebank
order by db:path($t)
return db:path($t)
)
for $p in $paths
let $n := index-of($paths, $p) - 1
let $tb := db:open("riario_tb", $p)/*:treebank
let $cts := "urn:cts:croala:nikolamodr01.croala1394919.croala-lat2w:body1.p" || $n
return insert node attribute xml:id { $cts } into $tb