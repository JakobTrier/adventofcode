# By JATR, 2025.11.16
# https://adventofcode.com/2024/day/13#part2

# Load the data
$puzzledata = Get-Content 2024day13.dat
$answer=0
for ($i = 0 ; $i -lt $puzzledata.count ; $i=$i+4 ) {

$ax = [int]$puzzledata[$i].split(":")[1].split(",").split("+")[1]
$ay = [int]$puzzledata[$i].split(":")[1].split(",").split("+")[3]
$bx = [int]$puzzledata[$i+1].split(":")[1].split(",").split("+")[1]
$by = [int]$puzzledata[$i+1].split(":")[1].split(",").split("+")[3]
[bigint]$px = [int]$puzzledata[$i+2].split(":")[1].split(",").split("=")[1]
[bigint]$py = [int]$puzzledata[$i+2].split(":")[1].split(",").split("=")[3]

[bigint]$px = $px + 10000000000000
[bigint]$py = $py + 10000000000000

[bigint]$top = [bigint]$ax*$py - [bigint]$ay*$px
[bigint]$bottom = $ax*$by - $bx*$ay

[bigint]$b=[bigint]$top/[bigint]$bottom
[bigint]$a=($py-$b*$by)/$ay

if ( $($top % $bottom) -eq 0 -and ($(($py-$b*$by) % $ay)) -eq 0) {
  
  
  [bigint]$answer = $answer + [bigint]$a*3+$b

  }

}
write-host "Answer: " $answer  
