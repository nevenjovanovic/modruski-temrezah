let $paras := element corpus {
for $file in doc("/home/neven/Repos/modruski-temrezah/vocabulary/riario_paragraphs_word_count.xml")//corpus/f/p
let $fileid := substring-before(substring-after($file/parent::f/@n/string(), ".croala-"), ".xml")
return element p { $file/@n , attribute ref { $fileid }, data($file)}
}
for $pp in $paras/p
let $pid := $pp/@n
group by $pid
return element { $pid } { data($pp) , $pp/@ref/string() }