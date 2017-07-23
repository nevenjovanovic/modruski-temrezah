let $p := "/home/neven/Downloads/linux_embedded/q10lemlat.csv"
let $f := file:read-text($p)
let $c := csv:parse($f)
return $c//record