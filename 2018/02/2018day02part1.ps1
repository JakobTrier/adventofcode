# By JATR, 2025.09.03
# https://adventofcode.com/2018/day/2

# Load the data
$puzzledata = Get-Content 2018day2.dat

$twoofakind   = 0
$threeofakind = 0
$alephbet = "abcdefghijklmnopqrstuvwxyz"

$puzzledata | Foreach {
	$counttwo = 0
	$countthree =0
	for ($i=0 ; $i -lt $alephbet.length ; $i++ ) {
		if (([regex]::Matches($_, $alephbet[$i] )).count -eq 2) {
           $counttwo = 1
		   write-host $_ $alephbet[$i]
		}			
		if (([regex]::Matches($_, $alephbet[$i] )).count -eq 3) {
           $countthree = 1
		   write-host $_ $alephbet[$i]
		}			
	}
	
	if ( $counttwo -eq 1 ) {
		$twoofakind = $twoofakind + 1
	}
	if ( $countthree -eq 1 ) {
		$threeofakind = $threeofakind + 1
	}
	
	}

Write-host $($twoofakind * $threeofakind)
