(: produce CTS URNs of nodes in docs in db modr-ed, list node ids :)
declare variable $db := ( "modr-ed" );
let $nodes := element table {
for $doc in db:open($db)//*:TEI
let $ctsurn := $doc//*:text/@xml:base/string()
for $node in $doc//*:text//*[name()]
let $subcts := replace(substring-after(path($node),"/Q{http://www.tei-c.org/ns/1.0}TEI[1]/Q{http://www.tei-c.org/ns/1.0}text[1]/"), "Q\{http://www.tei-c.org/ns/1.0\}", "")
return element tr {
  element td { $ctsurn || $subcts },
  element td { db:node-id($node) }
}
}
return db:create("modr-ed-cts-nodes", $nodes, "nodes", map { 'ftindex': true(), 'chop': false(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })