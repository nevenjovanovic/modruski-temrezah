(: query LemLat's webservice, retrieve just lemmata :)
declare function local:lemlat($form, $cts){
  let $base := "http://www.ilc.cnr.it/lemlat/cgi-bin/LemLat_cgi.cgi?wordform="
let $s := $base || $form
return element p {
  element form { 
  attribute id { $cts },
  $form },
  fetch:xml($s, map {
  'parser': 'html' } )//u
}
};

(: get path of the queried form, remove namespaces and first two elements TEI/text :)
declare function local:cleanpath($xp){
  replace(
  replace($xp, 'Q\{http://www\.tei-c\.org/ns/1\.0\}TEI\[1\]/Q\{http://www\.tei-c\.org/ns/1.0\}text\[1\]', ''),
  'Q\{http://www.tei-c.org/ns/1\.0\}',
  '')
};

(: transform XPath into CTS :)
declare function local:cleanpath-to-cts($path){
  replace(
    replace(
    replace($path, '//', ''),
    '[\[\]]',
    ''),
    '/',
    '.' )
};
for $w in db:open("modr-riar-texts","nikolamodr01.croala1394919.croala-lat2w.xml")/*:TEI/*:text/*:body//*:w
let $f := $w/string()
let $xp := local:cleanpath(path($w))
return local:lemlat($f, $xp)