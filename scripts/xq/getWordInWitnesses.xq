(: for each edition of a witness, get number of words in a paragraph :)

element corpus {
for $files in collection("modr-riar-texts")//*:TEI
where matches(db:path($files), 'lat([3-9]|10)')
let $c := for $p in $files//*:text//*:p
return element p { $p/@n , count($p//*:w[not(parent::*:supplied)]) }
return element f { 
attribute n { db:path($files)},
$c
}
}