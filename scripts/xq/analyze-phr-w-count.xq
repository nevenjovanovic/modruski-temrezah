declare function local:phrcount($p){
  count($p//*:phr)
};
declare function local:wcount($w){
  element { $w/name() } {
    if ($w/name()="s") then 
    attribute xml:id { replace($w/../@xml:id/string(), "morphlemma" , ".") || $w/../@n/string() || "." || $w/@n/string() }
    else() ,
    $w/@ana ,
    attribute w { count($w/*:w)},
    if ($w//*:phr) then attribute stilphr { local:phrcount($w) } ,
    if ($w/*:phr) then for $p in $w/*:phr
    return local:wcount($p)
    else()
  }
};
element div {
for $s in //*:s
return local:wcount($s)
}