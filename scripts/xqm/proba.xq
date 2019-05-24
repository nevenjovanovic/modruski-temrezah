import module namespace functx = "http://www.functx.com" at "functx.xqm";
declare function local:getcap($substring) {
  let $u := 
for $n in collection("modr-cts-urns")//w/@n/string()
return functx:substring-before-last($n, $substring)
return distinct-values($u)
};
declare function local:gettextgroup ($match) {
  let $u := 
for $n in collection("modr-cts-urns")//w/@n/string()
return substring-before($n, $match)
return distinct-values($u)
};
local:gettextgroup(".")