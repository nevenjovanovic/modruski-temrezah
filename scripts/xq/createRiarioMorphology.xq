(: Pull treebanks from the morphosyntax folder :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/morphosyntax/')
let $files := file:children($path)
return db:create("riario_tb", $path, (), map { 'intparse' : true() })