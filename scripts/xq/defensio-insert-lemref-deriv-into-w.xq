let $lemmata := element lem {
  for $w in db:open("def-lemlat","defensio-LEMLAT-TEI-manual.xml")/*:TEI/*:text/*:body/*:ab/*:w[@ana="deriv"]
let $orig := $w/*:orig/string()
let $lemref := attribute lemmaRef { distinct-values($w/*:interpGrp/*:interp/@n) }
return element w { $lemref , $orig }
}
for $l in $lemmata//w
let $lref := $l/@lemmaRef
let $occur := db:open("modr-def-texts","nikolamodr01.croala1394999.croala-lat2w.xml")/*:TEI/*:text/*:body//*:w[not(@lemmaRef) and replace(replace(lower-case(string()), 'v', 'u'), 'j', 'i')=$l/string()]
for $o in $occur
return insert node $lref into $o