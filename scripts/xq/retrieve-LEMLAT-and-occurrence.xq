declare function local:format-word($word){
  replace(
  replace(lower-case($word), "v", "u"),
  "j", "i")
};
declare function local:word-lemlat-occur($word){
  let $l := db:open("def-lemlat","defensio-LEMLAT-TEI-manual.xml")/*:TEI/*:text/*:body/*:ab/*:w[*:orig=$word]
let $occur := db:open("modr-def-texts","nikolamodr01.croala1394999.croala-lat2w.xml")/*:TEI/*:text/*:body//*:s[*:w[local:format-word(string())=$word]]
return element result { element s { normalize-space($occur) } , $l }
};
let $word := "aduersati"
return local:word-lemlat-occur($word)