(: for each edition of a witness, get number of words in a paragraph :)

declare function local:getversions($pid,$wid){
for $files in collection("modr-riar-texts")//*:TEI
let $path := db:path($files)
where matches($path, 'lat([3-9]|10)')
let $c := for $p in $files//*:text//*:p[@n=$pid]/*:w[@n=$wid]
return element tr { 
attribute n {
  substring-after($path, "croala-")
} , 
$p }
return $c
};
for $n in 1 to 25
let $pn := "p" || $n
return local:getversions($pn, "w10")