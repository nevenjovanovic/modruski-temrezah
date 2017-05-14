(: modr-cts-index-placename-into-db.xq :)
(: Create db with indices to cp elements with @n and @ana :)
(: cp includes two files :)
declare function local:ntree($words, $ctsname) {
  for $f in $words
let $tree := string-join(data($f/ancestor-or-self::*[@n]/@n),'.')
return element w { 
attribute xml:id {db:node-id($f)} , 
attribute n { $ctsname || ":" || $tree } , 
attribute aex { $ctsname || ".lexis:" || $tree } , 
$f/@ana , 
normalize-space(data($f)) }
};
let $windex :=
element wlist {
for $xmlfile in collection("modr-cts-texts")//*:TEI[descendant::*:text]
let $cts := $xmlfile//*:text/@xml:base
for $f in $xmlfile//*:text//*[@n]
let $ntree := local:ntree($f, $cts)
return $ntree
}
return db:create("modr-cts-urns", $windex, "modr-urns.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })