let $dbvalidation := map {
  'modr-cts-urns' :  'https://github.com/nevenjovanovic/modruski-temrezah/raw/master/scripts/schemas/cpctsurns.rng'
}
for $dbname in map:keys($dbvalidation)
for $doc in db:open($dbname)
let $result := validate:rng-report($doc, map:get($dbvalidation, $dbname))
let $valid := <report>
  <status>valid</status>
</report>
return if ($result=$valid) then format-date(current-date(), "[Y0001]-[M01]-[D01]") || " The db " || $dbname || " validates successfully."
else  format-date(current-date(), "[Y0001]-[M01]-[D01]") || " The db " || $dbname || " did not validate. Please inspect!"