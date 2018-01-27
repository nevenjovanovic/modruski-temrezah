(: return an individual paragraph :)
element corpus {
for $files in collection("modr-riar-texts")//*:TEI
let $name := db:path($files)
where matches($name, 'lat([3-9]|10)')
let $c := for $p in $files//*:text//*:p[@n="p3"]
return element div { 
attribute id {$name},
$p }
return $c }