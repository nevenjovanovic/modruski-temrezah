module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cts = "http://croala.ffzg.unizg.hr/cts" at '../xqm/croalacts.xqm';

(: return textgroups :)   

declare %unit:test function test:ctslist-groups() {
  let $group := "urn:cts:croala:nikolamodr01"
  let $href := "http://croala.ffzg.unizg.hr/basex/modr/" || $group
  let $urn := cts:groups("modr-cts-urns")//tr[parent::tbody]/td/a[@href=$href]/string()
  return unit:assert-equals($urn, $group)
};

(: return works :)
declare %unit:test function test:ctslist-works() {
  let $urn := collection("modr-cts-urns")//w/@n
  let $count := count($urn)
  let $uniq := count(distinct-values($urn))
  return unit:assert($count = $uniq)
};

(: return editions :)
declare %unit:test function test:ctslist-editions() {
  let $urn := collection("modr-cts-urns")//w/@n
  let $count := count($urn)
  let $uniq := count(distinct-values($urn))
  return unit:assert($count = $uniq)
};
