(: send a list of words to be lemmatized to Morpheus web service :)
let $rq := "http://morph.perseids.org/analysis/word?lang=lat&amp;engine=morpheuslat&amp;word="
let $words := ("gratitudinis", "memoriter", "nescierit", "nosse", "norunt", "quamobrem", "quotannis")
for $w in $words
let $path := $rq || $w
return fetch:text($path)