# By JATR, 2025.08.21
# https://adventofcode.com/2018/day/1#part2


# Load the data
$puzzledata = Get-Content 2018day1.dat

$answer = 0

$mypath = @($answer)

$resultnotfound = $true

$iteration = 0
# Go through the data one line at the time.. 

while ($resultnotfound) {
$currentTime = Get-Date -format "dd-MMM-yyyy HH:mm:ss"
$iteration++
Write-Host "Iteration:" $iteration "(" $currentTime ")" $mypath[$steps-1]
  $puzzledata | Foreach {

	$linedata = $_
    if ($linedata[0] -eq "+") { # plus
	   $answer = $answer + [int][string]$linedata.Substring(1) 
	} else { # minus
	   $answer = $answer - [int][string]$linedata.Substring(1)
	}
	
    $mypath = $mypath  + @($answer)
	$steps = $mypath.count 
	for ($i=0; $i -lt $steps-1 ; $i++) {
		# Write-Host $mypath[$i] $mypath[$steps-1]
		 if ($mypath[$i] -eq $mypath[$steps-1]) {
			  Write-Host "Bingo:" $mypath[$i]
			  $resultnotfound = $false
			  break
		 }
    }
  }
}

# $answer 73334-74162 (not 73888, 74124) . Correct answer: 73364 Foundin iteration 141
