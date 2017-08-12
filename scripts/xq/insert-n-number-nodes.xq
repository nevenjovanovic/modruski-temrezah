declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $docname := "nikolamodr01.croala1394919.croala-lat4.vulterris.xml";
copy $d := doc("/home/neven/Repos/modruski-temrezah/data/nikolamodr01/croala1394919/" || $docname)
modify ( 
for $n in $d//*:text//*
let $name := $n/name() 
let $count := count($n/preceding-sibling::*[name()=$name]) + 1 
return if ($n/@n) then replace value of node $n/@n with $name || $count
else insert node attribute n { $name || $count } into $n )
return file:write("/home/neven/Repos/modruski-temrezah/data/nikolamodr01/croala1394919/" || $docname, $d)