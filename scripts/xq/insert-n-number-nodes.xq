declare default element namespace "http://www.tei-c.org/ns/1.0";
copy $d := doc("/home/neven/Repos/modruski-temrezah/data/nikolamodr01/croala1394999/nikolamodr01.croala1394999.croala-lat1.xml")
modify ( 
for $n in $d//*:text//*
let $name := $n/name() 
let $count := count($n/preceding-sibling::*/[name()=$n]) + 1 
return if ($n/@n) then replace value of node $n/@n with $name || $count
else insert node attribute n { $name || $count } into $n )
return file:write("/home/neven/Repos/modruski-temrezah/data/nikolamodr01/croala1394999/nikolamodr01.croala1394999.croala-lat1.xml", $d)