# By JATR, 2025.08.26
# https://adventofcode.com/2015/day/25

$row=2947
$col=3029
$solnumber = ($row * $row - $row + 2)/2 + ($col - 1) * $row + ($col * $col - $col) / 2 

$code = 20151125 # kode nr 1

$multi = 252533
$div = 33554393
$count = $solnumber # 17850354

for ($i = 1; $i -lt $count; $i++) {
  $code = $code * $multi % $div
}

$code # 19980801
