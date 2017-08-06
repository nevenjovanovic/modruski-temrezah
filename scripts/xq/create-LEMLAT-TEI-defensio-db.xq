let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/vocabulary/')
let $p := $path || "defensio-LEMLAT-TEI-manual.xml"
return db:create("def-lemlat", $p, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })