(: produce and list all CTS URNs :)
declare variable $elements := ("p", "body", "head", "w");
for $d in db:open("modr-riar-texts", "nikolamodr01.croala1394919.croala-lat4.vulterris.xml")//*:TEI/*:text//*[name()=$elements and @n]
(: let $base := $d/ancestor::*:text/@xml:base :)
let $base := "modruski:croala-lat4.vulterris:"
let $base2 := "modruski:croala-lat2pw:"
let $urn := string-join($d/ancestor-or-self::*[@n]/@n, ".")
return element relation { 
attribute resp { "#viaf6913774" },
attribute ref { "saws:isVerbatimOf" },
attribute active { $base2 || $urn } , 
attribute passive { $base || $urn } 
}