(: group phr by @ana values, keep combinations, include node-ids :)
for $a in  db:open("modr-riar-rhet")//*:phr
let $value := $a/@ana/string()
let $loc := db:node-id($a)
group by $value
order by $value
return element tr { 
element td { $value } ,
element td { $loc }
}