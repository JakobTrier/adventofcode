# By JATR, 2025.08.20
# https://adventofcode.com/2020/day/1#part2

# Load the data
$puzzledata = Get-Content 2020day1.dat

$alldata = $null

$lastline = 0
$answer = -1

$puzzledata | Foreach { # load all data into an array
	$alldata = $alldata + @($_)
}
for ($j=0; $j -lt $alldata.count; $j++) { # Go through the data
  for ($i=0; $i -lt $alldata.count; $i++) { # Go through the data
    $sum = [int]$alldata[$i] + [int]$alldata[$j]
    if ( $sum -eq '2020' ) {
      if ( $i -ne $j ) { # avoid 2020/2=1010 being the number...
		 # Write-Host $i $j $alldata[$i] $alldata[$j]
		 $answer = [int]$alldata[$i] * [int]$alldata[$j]
		 Write-Host $answer
		 $j = $alldata.count # stop counting...
		 $i = $alldata.count # stop counting...
	  }
	}
  }
}
