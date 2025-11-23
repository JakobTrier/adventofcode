# By JATR, 2025.09.03
# https://adventofcode.com/2017/day/2#part2

# Load the data
$puzzledata = Get-Content 2017day2.dat

$answer = 0
$line=0
$puzzledata | Foreach {
	$line = $line +1
	$numbers = $_.split(" ")
    for ( $i = 0 ; $i -lt 16 ; $i++ ) {
		for ( $j = 0 ; $j -lt 16 ; $j++ ) {
			if ($i -ne $j ) {
				if ([int]$numbers[$j] -gt [int]$numbers[$i]) {
					if ( [int]$numbers[$j] % [int]$numbers[$i] -eq 0 ) {
						write-host $line ":" $numbers[$j] "/" $numbers[$i] "="  $( $numbers[$j] / $numbers[$i] )
						$answer = $answer + ( $numbers[$j] / $numbers[$i] )
					}
	
				}
			}
		}
	}
}
$answer
