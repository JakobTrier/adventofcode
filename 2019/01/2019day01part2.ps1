# By JATR, 2025.08.20
# https://adventofcode.com/2019/day/1#part2

# Load the data
$puzzledata = Get-Content 2019day1.dat

$alldata = $null
$answer = 0

$puzzledata | Foreach { # load all data into an array
	$alldata = $alldata + @($_)
}
  for ($i=0; $i -lt $alldata.count; $i++) { # Go through the data
    
    $fuel = 0
	
    $morefuel = [Math]::Floor($alldata[$i]/3) - 2
	while ( $morefuel -gt '0') {
	   $fuel = $fuel + $morefuel
	   $morefuel = [Math]::Floor($morefuel/3) - 2
    }
	$answer = $answer + $fuel
	write-host $i $alldata[$i] $fuel
   }

Write-Host $answer
