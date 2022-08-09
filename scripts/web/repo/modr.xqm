(: XQuery module for Nicolaus Modrusiensis, critical edition :)
module namespace nm = 'http://croala.ffzg.unizg.hr/nm';

(: helper function for header, with meta :)
declare function nm:htmlheadserver($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, CroALa, Nicolai Modrusiensis oratio in funere Petri (Riarii), 1474" />
<link rel="icon" href="/basex/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/static/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/static/dist/css/modr.css"/>
<link rel="stylesheet" type="text/css" href="/static/dist/font-awesome-4.7.0/css/font-awesome.min.css"/>
</head>

};

(: helper function for table :)
declare function nm:table ($headings, $body){
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    if ($headings="") then ()
    else
    element thead {
      element tr {
        for $h in $headings return element th { $h }
      }
    },
    element tbody {
      $body
    }
  }
};

(: helper - table row :)
declare function nm:tablerow($cells){
  element tr { $cells }
};

(: helper function - footer :)
declare function nm:footerserver () {
let $f := <footer class="footer">
<div class="container">
<h1 class="text-center"><span class="fa fa-leaf fa-fw" aria-hidden="true"></span> <a href="http://croala.ffzg.unizg.hr">CroALa</a>: Nicolai Modrusiensis Oratio in funere Petri (Riarii), 1474</h1>
<div class="row"> 
<div  class="col">
<h3 class="text-center"><a href="http://www.ffzg.unizg.hr"><img src="/basex/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</h3> 
<p class="text-center"><i class="fa fa-github fa-lg"></i>
            <span class="network-name">Github</span>: <a href="https://github.com/nevenjovanovic/modruski-ldlt">modruski-ldlt</a></p>
</div>
</div>
</div>
</footer>
return $f
};

(: helper function -- db info :)
declare function nm:infodb($dbname) {
  (: return info on modr-riar-rhet db, with Latin field names :)
let $week := map {
  "name": "nomen",
  "documents": "documenta",
  "timestamp": "de dato"
}
return element table { 
attribute class { "pull-right"},
let $i := db:info($dbname)/databaseproperties
  for $n in ('name','documents','timestamp')
  return 
   element tr {
    element td { map:get($week, $n) } ,
    element td { $i/*[name()=$n] }
  }
}
};

(: make link to file in db :)
declare function nm:filenode ($txtnode) { 
element a {
  attribute href { $nm:urn || "/" || $nm:db || "/" || $txtnode } ,
  $txtnode
}

 };


(: return list of lemmata and counts of occurrences :)
declare function nm:phrlist($db){
for $l in db:open($db)//*:phr
let $l1 := $l/@ana/string()
let $oc := path($l)
return element tr {
  element td { $l1 },
  element td { $oc }
}  
};

(: return total count of lemmata and of occurrences :)
declare function nm:phrinfo($db){
let $lem := db:open($db)//*:phr
let $occount := count( for $a in $lem/*:anchor return $a )
return "Phraseis: " || count($lem)  || ". Figurae occurrentes: " || $occount  || ".
"
};

(: table of contents :)

declare variable $nm:urn := "http://localhost:8984/";
declare variable $nm:db := "modr-riar-ldlt";

declare function nm:tabulaorationis() {
let $base := db:open($nm:db)//*:fileDesc/@xml:id
let $d := db:open($nm:db)//*:front/*:div/*:div[@xml:id="preface-section-2"]
for $i in $d//*:interp
let $ref := $i/@corresp
let $ref2 := substring-after($ref, "#")
let $target := db:open($nm:db)//*:body//*:p[@xml:id=$ref2]
let $a := path($target)
let $aid := db:node-id($target)
let $a2 := replace($a, "Q\{http://www.tei-c.org/ns/1.0\}", "")
let $row := (
element td { $i/string() },
element td { $ref/string() } ,
element td { 
element a {
  attribute href { $nm:urn || $base/string() || "/" || $aid } ,
   $base || $a2 } }
)
return nm:tablerow($row)
};
