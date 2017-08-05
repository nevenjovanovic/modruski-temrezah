let $forms :=
let $doc := db:open("modr-def-texts","nikolamodr01.croala1394999.croala-lat2w.xml")/*:TEI/*:text/*:body//*:w
return distinct-values($doc)
let $unique_forms := for $f in $forms
order by $f
return replace(
  replace(lower-case($f), "v", "u"), "j", "i"
)
return distinct-values($unique_forms)