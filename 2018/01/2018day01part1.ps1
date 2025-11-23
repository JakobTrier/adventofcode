# By JATR, 2025.08.19
# https://adventofcode.com/2018/day/1

# Load the data
$puzzledata = Get-Content 2018day1.dat

$answer = 0

# Go through the data one line at the time
$puzzledata | Foreach {
	$linedata = $_
    if ($linedata[0] -eq "+") { # plus
	   $answer = $answer + [int][string]$linedata.Substring(1) 
	   
	} else { # minus
	   $answer = $answer - [int][string]$linedata.Substring(1)
	}
}
$answer
