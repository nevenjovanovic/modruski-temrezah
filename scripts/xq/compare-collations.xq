(: Retrieve all printed editions :)
declare function local:getset() {
let $db := "modr-riar-texts"
for $string in (".ed-", ".ms-")
for $f in db:list($db)
where contains($f, $string)
return  db:open($db , $f)//*:text[@xml:base]
};

for $p in local:getset()
let $para :=$p//*:p[20]
let $base := $p/@xml:base
(: return all w elements from starting to position :)
(: return all children of w called sic orig expan abbr :)
(: check if an immediate following element is "supplied", if so, report an omission :)
(: NB what if there is supplied after pc? test also for the second following sibling... :)
let $words :=
let $coord := (0,50)
for $w in $para/*:w[position() > $coord[1] and position() < $coord[2]]
return if ( $w/*[name()=("sic", "orig", "expan", "abbr")] ) then $w/* 
else if ($w/following-sibling::*[1][self::*:supplied] or $w/following-sibling::*[2][self::*:supplied]) then ( $w/string() , "OMISIT!" )
else if ($w/following-sibling::*[1][self::*:add] or $w/following-sibling::*[2][self::*:add]) then ( $w/string() , $w/following-sibling::*:add[1] ) 
else if ($w/following-sibling::*[1][self::*:surplus] or $w/following-sibling::*[2][self::*:surplus]) then ( $w/string() , $w/following-sibling::*:surplus[1] )
else $w/string()
return element rdg { $base , $words }
