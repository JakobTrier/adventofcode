# By JATR, 2025.11.03
# https://adventofcode.com/2022/day/3

# Load the data
$puzzledata = Get-Content 2022day03.dat

$answer = 0
for ($i = 0 ; $i -lt $puzzledata.length ; $i++ ) {
  for ($j = 0 ; $j -lt ($puzzledata[$i].length/2) ; $j++) {
    if ( $($puzzledata[$i][$($puzzledata[$i].length/2)..$($puzzledata[$i].length-1)]).IndexOf($puzzledata[$i][0..$($puzzledata[$i].length/2-1)][$j]) -ne -1)  {
	   $a = $puzzledata[$i][0..$($puzzledata[$i].length/2-1)][$j]
	   $prioritynumber = [byte][char]$puzzledata[$i][0..$($puzzledata[$i].length/2-1)][$j] - 96
	   if ($prioritynumber -lt 0 ) {
		   $prioritynumber = $prioritynumber + 58
	   }
	   # end the search when the first match is found in a line.
	   $j = ($puzzledata[$i].length/2) 
	   $answer = $answer + $prioritynumber
	  }
  }
}
write-host "Answer: " $answer
