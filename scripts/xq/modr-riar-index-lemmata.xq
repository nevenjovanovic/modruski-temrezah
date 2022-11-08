(: index lemmata alphabetically :)
declare function local:row($cells){
  element tr {
    $cells
  }
};
for $w in db:open("modr-riar-rhet")//*:w[@lemmaRef]
let $lemma := $w/@lemma
group by $lemma
order by $lemma
return local:row( (
element td { $lemma }, 
element td { count($w)}, 
element td { db:node-id($w) } ) )
