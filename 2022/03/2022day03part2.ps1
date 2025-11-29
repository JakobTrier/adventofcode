# By JATR, 2025.11.03
# https://adventofcode.com/2022/day/3#part2

# Load the data
$puzzledata = Get-Content 2022day03.dat

$answer = 0
for ($i = 0 ; $i -lt $puzzledata.length ; $i=$i+3 ) {
	# first find all letters from line 1 which appear in line 2.
	$badge = ""
	for ($j = 0 ; $j -lt ($puzzledata[$i].length) ; $j++) {
      if ( $puzzledata[$i+1].IndexOf($puzzledata[$i][$j]) -ne -1)  {
		$badge=$badge + $puzzledata[$i][$j]
      }
	}
	# next use the list just created to see whcih of these appear in line 3	
	for ($j = 0 ; $j -lt ($badge.length) ; $j++) {
      if ( $puzzledata[$i+2].IndexOf($badge[$j]) -ne -1)  {
		write-host "Svar: " $badge[$j]
		$prioritynumber = [byte][char]$badge[$j] -96
	    if ($prioritynumber -lt 0 ) {
		   $prioritynumber = $prioritynumber + 58
	    }	
        $answer = $answer + $prioritynumber		
		$j = $badge.length
      }
	}		
}	
write-host "Answer: " $answer
