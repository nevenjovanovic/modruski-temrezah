(: create a smaller db of LiLa lemmata from the Riario speech :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/lemmata/lilamodr.xml') 
return db:create("modr-lila", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })