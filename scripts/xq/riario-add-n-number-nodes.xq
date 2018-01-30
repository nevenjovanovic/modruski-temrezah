declare default element namespace "http://www.tei-c.org/ns/1.0";
for $n in collection("modr-riar-texts")//*:text//*
let $name := $n/name() 
let $count := count($n/preceding-sibling::*[name()=$name]) + 1 
return if ($n/@n) then replace value of node $n/@n with $name || $count
else insert node attribute n { $name || $count } into $n