module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cts = "http://croala.ffzg.unizg.hr/cts" at '../xqm/croalacts.xqm';

(: each CTS URN is distinct :)   

declare %unit:test function test:ctsurn-unique() {
  let $urn := collection("modr-cts-urns")//w/@n
  let $count := count($urn)
  let $uniq := count(distinct-values($urn))
  return unit:assert($count = $uniq)
};

(: each CTS has a node in modr-cts-texts :)
(: node values in idx and texts are equal :)
declare %unit:test function test:ctsurn-node() {
  for $urn in collection("modr-cts-urns")//w/@xml:id
  let $node := normalize-space(data(db:open-id("modr-cts-texts", $urn)))
  return unit:assert-equals($urn/../string() , $node)
};

(: return a list of CTS URNs :)
declare %unit:test function test:ctsurn-list() {
  let $db := "modr-cts-urns"
  let $count := count(collection($db)//w)
  let $urns := count(cts:getcapabilities($db)//tr)
  return unit:assert-equals($urns, $count)
};