# By JATR, 2025.08.21
# https://adventofcode.com/2015/day/1


# Load the data
$puzzledata = Get-Content C:\jatr\2015day1.dat


$answer = 0

for ($i=0;$i -lt $puzzledata.Length;$i++) {
    if ( $puzzledata[$i] -eq '(' ) {
	  	$answer = $answer + 1
	} 
	if ( $puzzledata[$i] -eq ')' ) {
	  	$answer = $answer -1 
	}
	if ( $answer -eq -1) {
		write-host "In the basement: " $($i+1)
	}
}

$answer #1: 75  #2: 1795




