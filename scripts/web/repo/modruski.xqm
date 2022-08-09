(: XQuery module for Modruski :)
module namespace modruski = 'http://croala.ffzg.unizg.hr/modruski';

(: helper function for header, with meta :)
declare function modruski:htmlheadserver($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, CroALa" />
<link rel="icon" href="/basex/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/modruski.css"/>
<script type="text/javascript" src="/basex/static/dist/js/clipboard.min.js"></script>
</head>

};

(: formatting - footer :)
declare function modruski:footerserver () {
let $f := <footer class="footer">
<div class="container">
<h3> </h3>
<h1 class="text-center"><span class="glyphicon glyphicon-leaf" aria-hidden="true"></span> <a href="http://croala.ffzg.hr/">Croatiae auctores Latini</a></h1>
<div class="row">
<div  class="col-md-3"></div> 
<div  class="col-md-6">
<p class="text-center"><a href="http://www.ffzg.unizg.hr"><img src="/basex/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</p></div>
<div  class="col-md-3"></div></div>
</div>
</footer>
return $f
};


declare function modruski:substring-before-last
  ( $arg ,
    $delim ) {

   if (matches($arg, $delim))
   then replace($arg,
            concat('^(.*)', $delim,'.*'),
            '$1')
   else ''
 } ;
declare function modruski:substring-after-last
  ( $arg ,
    $delim ) {

   replace ($arg,concat('^.*',$delim),'')
 } ;
 declare function modruski:getpassage ($urn){
   let $cts := collection("modruskicitconfig")//*:online
   for $t in $urn
let $urn1 := modruski:substring-before-last($t, ":") || ":"
let $xpath := modruski:substring-after-last($t, ":")
let $xpathphr := "//*[@n='" || replace($xpath, "\.", "']/*[@n='") || "']"
let $xpathphr2 := modruski:substring-before-last($xpathphr, "/")
let $passage := xquery:eval($xpathphr2, map { '': db:open('modruskiriario', data($cts[@urn=$urn1]/@docname)) })
return element tr { 
element td { $t } , 
element td {
normalize-space(data($passage)) }
}
 };
 
declare variable $modruski:urn := "https://croala.ffzg.unizg.hr/basex/nm-stil/node/";
declare variable $modruski:dbrhet := "modr-riar-stil";
declare variable $modruski:urlnidus := "https://croala.ffzg.unizg.hr/basex/nm-stil/nidificium/";
declare variable $modruski:heatmap := map { 
0: "#9ef738",
1: "#93e436",
2: "#7ec231",
3: "#689e2c",
4: "#598527",
5: "#527925",
6: "#4b6e23",
7: "#446221",
8: "#3d571e"
};
declare function modruski:notaeABC($seq){
  (: order terms in @ana alphabetically :)
  let $seqabc := string-join( for $s in tokenize($seq, " ")
  order by $s
  return $s (: replace($s, "-", "") :)
  , " ")
  return $seqabc
};

declare function modruski:makeurl($a){ 
(: helper function: format url for node as link :)
element a { attribute href { $modruski:urlnidus || db:node-id($a) } , db:node-id($a) }
};

declare function modruski:nestlist($min) {
  (: retrieve number of nests, their @ana values :)
  (: $min declares minimal number of nested elements :)
let $nestvalues :=
for $p in db:open($modruski:dbrhet)//*:text//*:s/*:phr
let $ana := modruski:notaeABC($p/@ana/string())
let $id := element a { attribute href { $modruski:urlnidus || db:node-id($p) } , db:node-id($p) }
let $count := count($p//*:phr)
let $desc := for $a in $p//*:phr/@ana/string() return element pre { modruski:notaeABC($a) }
where $count >= $min
order by $ana
return element tr { 
 attribute style { "background-color:" || map:get($modruski:heatmap , count($p//*:phr)) },
element td { $id },
element td { $ana },
element td { $count },
element td { $desc }
 }
return $nestvalues
};

declare function modruski:nestlistlevel($min) {
  (: for phr, return column of children and column of other descendants :)
let $nestvalues :=
for $p in db:open($modruski:dbrhet)//*:text//*:s/*:phr
let $ana := modruski:notaeABC($p/@ana/string())
let $id := modruski:makeurl($p)
let $count := count($p//*:phr)
let $children := for $a in $p/*:phr/@ana return ( modruski:makeurl($a/parent::*) , element pre { modruski:notaeABC($a/string()) } )
let $childcount := count($children) div 2
let $desc := for $a in $p/*:phr//*:phr/@ana return  ( modruski:makeurl($a/parent::*) , element pre { modruski:notaeABC($a/string()) } )
let $desccount := count($desc) div 2
where $count >= $min and $desccount > 0
order by $ana
return element tr { 
 attribute style { "background-color:" || map:get($modruski:heatmap , count($p//*:phr)) },
element td { $id },
element td { $ana },
element td { $count },
element td { $childcount },
element td { $children },
element td { $desccount },
element td { $desc }
 }
return $nestvalues
};

declare function modruski:index-stilisticus() {
(: get all phr elements annotated with style, as table :)

let $base := db:open($modruski:dbrhet)//*:fileDesc/@xml:id
for $p in db:open($modruski:dbrhet)//*:text//*:phr
let $ana := $p/@ana
let $ananode := db:node-id($p)
let $a := path($p)
let $a2 := replace($a, "Q\{http://www.tei-c.org/ns/1.0\}", "")
return element tr { 
element td { $ananode },
element td { $ana/string() } ,
element td { 
element a {
  attribute href { $modruski:urn || $ananode } ,
   $base || $a2 } }
}
};

declare function modruski:opennode($node){
  for $i in $node
for $phr in db:open-id($modruski:dbrhet, $i)
return element tr {
  element td { $i }, 
  element td { $phr/@ana/string() }, 
  element td { normalize-space($phr) }
}
};

declare function modruski:getnest($node){
  for $i in $node
for $phr in db:open-id($modruski:dbrhet, $i)
let $desc := for $p in $phr//*:phr/@ana/string() return element pre { $p }
return element tr {
  element td { $i }, 
  element td { $phr/@ana/string() }, 
  element td { $desc },
  element td { normalize-space($phr) }
}
};

declare function modruski:getallnodes($term){
  (: for term, retrieve all nodes :)
  for $t in $term
let $phr := db:open($modruski:dbrhet)//*:phr[matches(@ana, $t)]
return modruski:opennode(db:node-id($phr))
};

declare function modruski:indiculus(){
(: get all phr elements annotated with style, as table :)
(: index phr/@ana, separate values, tokenize to get individual values (@ana may carry more than one) :)
(: count occurrences of individual values :)
let $rows := element tbody {
let $stylevalues :=
for $p in db:open($modruski:dbrhet)//*:text//*:phr
let $ana := $p/@ana/string()
return tokenize($ana, " ")
for $dv in distinct-values($stylevalues)
return element tr {
  element td { $dv } ,
  element td { count($stylevalues[. eq $dv]) }
}
}
for $r in $rows/tr
  let $term := substring-after($r/td[1]/string(), "#")
  let $url := "https://croala.ffzg.hr/basex/nm-stil/terminus/"
  order by xs:integer($r/td[2]/string()) descending
  return element tr {   
  element td { db:open($modruski:dbrhet)//*:interp[@xml:id=$term]/string()}, 
  element td { 
  element a { attribute href { $url || $term} , $term } } ,
  $r/td[2] }
};
(: retrieve phr trees with all levels :)
declare function modruski:allnests(){
  (: max descendant depth 4, get all phr, id and @ana :)
  (: format as links to individual segments :)
  element tbody {
for $p in db:open($modruski:dbrhet)//*:text//*:s/*:phr
let $ana := modruski:notaeABC($p/@ana/string())
let $id := modruski:makeurl($p)
let $child := $p/*:phr
let $childid := for $d in $child return modruski:makeurl($d)
let $childana := for $c in $child return element pre { modruski:notaeABC($c/@ana/string()) }
let $desc1 := $p/*:phr/*:phr
let $desc1id := for $d in $desc1 return modruski:makeurl($d)
let $desc1ana := for $d in $desc1 return element pre { modruski:notaeABC($d/@ana/string()) }
let $desc2 := $p/*:phr/*:phr/*:phr
let $desc2id := for $d in $desc2 return modruski:makeurl($d)
let $desc2ana := for $d in $desc2 return element pre { modruski:notaeABC($d/@ana/string()) }
return element tr { 
element td { $id }, element td { $ana },
element td { $childid } ,  element td { $childana },
element td { $desc1id } ,  element td { $desc1ana },
element td { $desc2id } , element td { $desc2ana }
 }
}
};
declare function modruski:filternest($f) {
  (: select only phr with descendants level $f, 1-4 :)
for $n in modruski:allnests()/tr
let $ff := $f * 2
where not($n/td[$ff]="")
return $n
};

declare variable $modruski:dblect := "modr-riar-ldlt";
declare variable $modruski:urn-lect := "https://croala.ffzg.unizg.hr/basex/";
declare function modruski:indiculuslectionum(){

for $p in db:open($modruski:dblect)//*:text//*:rdg
let $type := $p/@type
group by $type
order by count($p) descending
return element tr { 
element td { $type },
element td { element a { 
attribute href { $modruski:urn-lect || "nm-lectionum-typi/" || $type } , count($p) } }

}
};

declare function modruski:lectionespertypum($typus){
  
for $p in db:open($modruski:dblect)//*:text//*:app[*:rdg/@type=$typus]
return element tr { 
element td { $typus },
element td { db:node-id($p) },
element td { $p/*:lem },
element td { for $r in $p/*:rdg[@type=$typus]
return $r/@wit/string() || ": " || $r/string() } }


};
(: CTS URNs :)
(: variables :)
declare variable $modruski:db-cts := ( "modr-ed" );
declare variable $modruski:croala-cts := ( "https://croala.ffzg.unizg.hr/basex/modr-ed/cts/" );

(: remove colon from CTS in doc / xml base :)
declare function modruski:removecolon($urn){
  if (ends-with($urn, ":")) then replace($urn, ":$", "")
  else()
};

(: format hyperlink for card :)

declare function modruski:hrefcard($ctsurn){
  element a {
    attribute class { "card-link" } , 
    attribute href { $modruski:croala-cts || $ctsurn },
    $ctsurn
  }
};

(: format link for a CTS URN in document :)

declare variable $modruski:croala-cts-doc := ( "https://croala.ffzg.unizg.hr/basex/modr-ed/cts/doc/" );

declare function modruski:hrefsub($docurn){
  element a {
    attribute class { "card-link" } , 
    attribute href { $modruski:croala-cts-doc || $docurn },
    $docurn
  }
};

(: list available documents and their CTS URNs, descriptions :)

declare function modruski:listctsdocs(){
  for $doc in db:open($modruski:db-cts)//*:TEI
let $ctsurn := modruski:hrefcard( modruski:removecolon($doc//*:text/@xml:base/string()) )
let $abstract := normalize-space($doc//*:teiHeader/*:profileDesc/*:abstract/*:p/string())
return element div {
  attribute class { "card" } , 
  element div { 
  attribute class { "card-body" } , 
  $ctsurn ,
  element p { 
  attribute class { "card-text" } , $abstract } }
}
};

(: helper functions for the listctssuburns :)

(: give only first six words of text :)

declare function modruski:preview($textpreview){
  if ($textpreview[2]) 
then string-join($textpreview[position() < 6], " ") || "..."
else $textpreview
};

(: format as p in a bootstrap card :)
declare function modruski:cardtext($text, $label){
  element p { 
attribute class { "card-text" } , 
element b { $label } ,
$text
 }
};

(: for a document CTS URN, list all available URNs, with preview and link to content :)

declare function modruski:listctssuburns($urn){
  let $urn2 := $urn || ":"
  for $resource in db:open($modruski:db-cts)//*:TEI/*:text[@xml:base=$urn2]//*[name()]
let $textpreview := tokenize(normalize-space($resource/string()), " ")
let $attribs := if ($resource/@*) then string-join(for $a in $resource/@* return $a/name() || ": " || $a/string(), "; ") else "ABSUNT ATTRIBUTA"
let $which := replace(substring-after(path($resource),"/Q{http://www.tei-c.org/ns/1.0}TEI[1]/Q{http://www.tei-c.org/ns/1.0}text[1]/"), "/?Q\{http://www.tei-c.org/ns/1.0\}", "")
let $docurn := $urn2 || $which
return element div { 
attribute class { "card"},
element div {
  attribute class { "card-body"},

modruski:hrefsub($docurn) ,
modruski:cardtext($which, "Semita: "),
modruski:cardtext(modruski:preview($textpreview), "Legitur: "),
modruski:cardtext($attribs, "Notae: ")

}
}
};

(: for an individual CTS URN, display information, link prev and next URNs:)

declare function modruski:displayctsdocurn($urn) {
  element p { "TBA" }
};