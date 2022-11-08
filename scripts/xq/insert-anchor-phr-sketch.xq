copy $f := <table>
<tr ana="a b c">
<w>riječ</w>
</tr>
</table>
modify ( for $n in tokenize($f/tr/@ana/string(), " ")
return insert node element anchor { attribute ana { $n } } before $f/tr/w )
return $f