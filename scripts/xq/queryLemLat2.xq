(: query LemLat's webservice, retrieve just lemmata :)
declare function local:lemlat($form){
  let $base := "http://www.ilc.cnr.it/lemlat/cgi-bin/LemLat_cgi.cgi?wordform="
let $s := $base || $form
return element p {
  element form {
  $form },
  fetch:xml($s, map {
  'parser': 'html' } )//u
}
};

(: send each wordform to the lemmatizer only once :)
let $forms := distinct-values (
for $w in db:open("modr-riar-texts","nikolamodr01.croala1394919.croala-lat2w.xml")/*:TEI/*:text/*:body//*:w
let $f := $w/string()
return lower-case($f)
)
for $f in $forms
return local:lemlat($f)