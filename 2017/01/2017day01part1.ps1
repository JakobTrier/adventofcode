# By JATR, 2025.08.15
# https://adventofcode.com/2017/day/1

# Load the data
$puzzledata = Get-Content C:\jatr\2017day1.dat

$previousnumber = $puzzledata[$puzzledata.Length-1]
$answer = 0

for ($i=0;$i -lt $puzzledata.Length;$i++) {
    if ( $puzzledata[$i] -eq $previousnumber ) {
	  	$answer = $answer + $previousnumber -48
	}
	[int]$previousnumber = $puzzledata[$i]
}
