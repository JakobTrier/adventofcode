# By JATR, 2025.08.20
# https://adventofcode.com/2021/day/1

# Load the data
$puzzledata = Get-Content 2021day1.dat

$lastline = 0
$answer = -1

# Go through the data one line at the time
$puzzledata | Foreach {
	$linedata = $_
    if ( [int]$linedata -gt [int]$lastline ) { 
      $answer++
	  Write-Host $linedata "(increased)"
   	} else {
		Write-Host $linedata "(decreased)"
	}
	
    $lastline = $linedata
}

$answer
