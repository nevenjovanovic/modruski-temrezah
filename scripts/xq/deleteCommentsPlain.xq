(: delete comments in basic text version :)
let $doc := db:open("modr-riar-texts")/*:TEI/*:teiHeader/*:encodingDesc/*:tagsDecl
return delete node $doc