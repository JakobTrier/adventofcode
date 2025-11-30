# By JATR, 2025.08.20
# https://adventofcode.com/2021/day/1#part2

# Load the data
$puzzledata = Get-Content 2021day1.dat

$alldata = $null

$lastline = 0
$answer = -1

$puzzledata | Foreach { # load all data into an array
	$alldata = $alldata + @($_)
}

for ($i=0; $i -lt $alldata.count-2; $i++) { # Go through the data
  $currentline = [int]$alldata[$i] + [int]$alldata[$i+1] + [int]$alldata[$i+2]
  if ( $currentline -gt $lastline ) {
	 $answer++
    }
    $lastline = $currentline
}

$answer
