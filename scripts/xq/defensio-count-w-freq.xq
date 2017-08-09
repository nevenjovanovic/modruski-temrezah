(: count frequencies of w elements :)
element list {
for $w in db:open("modr-def-texts","nikolamodr01.croala1394999.croala-lat2w.xml")/*:TEI/*:text//*:w[not(@lemmaRef)]
let $orig := $w/string()
let $form := replace(
  replace(lower-case($orig), "v", "u"), "j", "i")
group by $form
order by count($w) , $form
return element w { element f { $form } ,
element o { $orig } , 
element c { count($w) }
}
}