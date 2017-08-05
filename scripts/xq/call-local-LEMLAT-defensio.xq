let $lemlat_path := "/home/neven/Downloads/linux_embedded/lemlat"
let $source_path := "/home/neven/Repos/modruski-temrezah/vocabulary/defensio-word-list.txt"
let $output_path := "/home/neven/Repos/modruski-temrezah/vocabulary/defensio-word-list.xml"
return proc:system($lemlat_path, ('-i', $source_path, '-x', $output_path))