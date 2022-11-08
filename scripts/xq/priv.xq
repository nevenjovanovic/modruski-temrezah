for $q in "rumbus"
let $lemmaB := collection("lemmaBank")//*:Description[*:label[string()=$q]]
return $lemmaB