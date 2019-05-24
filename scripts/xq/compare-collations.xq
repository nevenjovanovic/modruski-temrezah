(: Retrieve all printed editions :)
declare function local:getset() {
let $db := "modr-riar-texts"
for $string in (".ed-", ".ms-")
for $f in db:list($db)
where contains($f, $string)
return  db:open($db , $f)//*:text[@xml:base]
};

for $p in local:getset()
let $para :=$p//*:p[1]
let $base := $p/@xml:base
let $words :=
let $coord := (45, 55)
for $w in $para/*:w[position() > $coord[1] and position() < $coord[2]]
return $w/string()
return element p { $base , $words }
