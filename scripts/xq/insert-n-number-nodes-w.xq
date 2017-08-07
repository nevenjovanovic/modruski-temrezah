declare default element namespace "http://www.tei-c.org/ns/1.0";
copy $d := doc("/home/neven/Repos/modruski-temrezah/data/nikolamodr01/croala1394999/nikolamodr01.croala1394999.croala-lat2w.xml")
modify ( 
for $n in $d//*:text//*:w
let $count := count($n/preceding-sibling::*:w) + 1 
return if ($n/@n) then replace value of node $n/@n with "w" || $count
else insert node attribute n { "w" || $count } into $n )
return file:write("/home/neven/Repos/modruski-temrezah/data/nikolamodr01/croala1394999/nikolamodr01.croala1394999.croala-lat2w.xml", $d)