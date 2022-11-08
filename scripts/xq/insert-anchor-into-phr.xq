(: tokenize @ana values, for each insert anchor into phr :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
for $n in db:open("modr-riar-rhet")//*:phr
for $t in  tokenize($n/@ana/string(), " ")
let $a := element anchor {
  attribute ana {
    $t
  }
}
return insert node $a into $n