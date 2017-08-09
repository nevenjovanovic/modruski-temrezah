let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/vocabulary/')
let $p := $path || "defensio-LEMLAT-TEI-manual.xml"
let $doc := db:open("def-lemlat","defensio-LEMLAT-TEI-manual.xml")/*:TEI
return file:write($p, $doc)