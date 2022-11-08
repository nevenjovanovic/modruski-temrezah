(: create a db of LiLa lemmata from the Riario speech :)
let $path := replace(file:parent(static-base-uri()), '/scripts/xq/', '/lemmata/lilalemma2.xml') 
return db:create("riar-lila2", $path, (), map { 'ftindex': true(), 'intparse' : true(), 'chop' : false() })