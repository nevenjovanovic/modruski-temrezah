let $lemmata := element lem {
  for $w in db:open("psl-lemlat")//*:ab/*:w[not(@ana)]
let $orig := $w/*:orig/string()
let $lemref := attribute lemmaRef { $w/*:interpGrp/*:interp/@n }
return element w { $lemref , $orig }
}
for $l in $lemmata//w
let $lref := $l/@lemmaRef
let $occur := db:open("psl-sent")//*:div/*:s/*:w[not(@lemmaRef) and lower-case(string())=$l/string()]
for $o in $occur
return insert node $lref into $o