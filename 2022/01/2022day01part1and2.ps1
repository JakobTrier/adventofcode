# By JATR, 2025.08.20
# https://adventofcode.com/2022/day/1#part2

# Load the data
$puzzledata = Get-Content 2022day01.dat

$elfs = 1
$calories = 0
$allelfdata = $null

# Go through the data one line at the time
$puzzledata | Foreach {
	$linedata = $_
	if ($linedata -eq "") { # done with a set of data
		$elfdata = @($elfs,$calories)
		$allelfdata = $allelfdata  + $elfdata
		$elfs = $elfs + 1
		$calories = 0
	} else {
		$calories = $calories + $linedata
	}
}
$elfdata = @($elfs,$calories)
$allelfdata = $allelfdata  + $elfdata
	
# Now it is time to sort the data....

# remember: $allelfdata
  
for ($j=0; $j -lt $elfs ; $j++) {
 for ($i=0; $i -lt $elfs ; $i++) {
  if ($allelfdata[$i*2+1] -lt $allelfdata[$i*2+3] ) { #if .. then swap values
	  $temp1 = $allelfdata[$i*2+1] 
	  $temp2 = $allelfdata[$i*2] 
	  
	  $allelfdata[$i*2+1] = $allelfdata[$i*2+3] 
	  $allelfdata[$i*2] = $allelfdata[$i*2+2] 
	  
	  $allelfdata[$i*2+3]  = $temp1
	  $allelfdata[$i*2+2]  = $temp2
  }
 }
}

Write-host "Part 1: " $allelfdata[1]
$answer = $allelfdata[1] +$allelfdata[3] +$allelfdata[5]
Write-host "Part 2: " $answer
