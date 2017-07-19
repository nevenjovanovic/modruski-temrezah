let $f := (
  "nikolamodr01.croala1394919.croala-lat2w.xml",
"nikolamodr01.croala1394919.croala-lat4.vulterris.xml",
"nikolamodr01.croala1394919.croala-lat6.guldinbeck.xml",
"nikolamodr01.croala1394919.croala-lat5.cerdonis.xml",
"nikolamodr01.croala1394919.croala-lat7.gensberg.xml",
"nikolamodr01.croala1394919.croala-lat8.rostock.xml",
"nikolamodr01.croala1394919.croala-lat3.plannck.xml"
)
for $p in db:open("modr-cts-texts", $f[2])/*:TEI/*:text//*
let $xp := path($p)
let $xp1 := xquery:eval($xp, map { '': db:open("modr-cts-texts", $f[2]) })
let $xp2 := xquery:eval($xp, map { '': db:open("modr-cts-texts", $f[3]) })
where not($xp1 = $xp2)
return replace(
  replace($xp, 'Q\{http://www\.tei-c\.org/ns/1\.0\}TEI\[1\]/Q\{http://www\.tei-c\.org/ns/1.0\}text\[1\]', ''),
  'Q\{http://www.tei-c.org/ns/1\.0\}',
  '')