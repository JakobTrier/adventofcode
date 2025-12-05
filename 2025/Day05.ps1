# By JATR, 2025.12.05
# https://adventofcode.com/2025/day/5

$puzzledata            = Get-Content 2025day05.dat                                # Load the data, it must be copied from https://adventofcode.com/2025/day/5/input and saved in a file called 2025day05.dat
[int]$answer1          = 0                                                        # Declare variable used to store answer 
[int64]$answer2        = 0                                                        # Declare variable used to store answer 

$firstid   = @()
$lastid    = @()
$goodrange = @()
$pos       = 0

# Part 1
$puzzledata | foreach-object {
  if ( $_.contains("-") ) {  
    $firstid += $_.split("-")[0]
    $lastid  += $_.split("-")[1]
	$goodrange += $_ # needed for part 2
  } else {
	$good = $false	
    for ($i = 0 ; $i -lt $firstid.count ; $i++ ) {
	  if (([int64]$_ -ge [int64]$firstid[$i]) -and ([int64]$_ -le [int64]$lastid[$i]) ) {
		 $good = $true		 
	  }
	}
	if ( $good ){$answer1++}
  }
}

# Part 2
for ( $j = 0 ; $j -lt ($goodrange.length - 1); $j++ ){  # Sort the good ranges
  for ( $i = 0 ; $i -lt ($goodrange.length - 1) ; $i++ ){
	if ( [int64]$goodrange[$i].split("-")[0] -gt [int64]$goodrange[$i+1].split("-")[0] ) {
	  $temp = $goodrange[$i]
	  $goodrange[$i] = $goodrange[$i+1]
	  $goodrange[$i+1] = $temp
	}	
  }
}

$goodrange | foreach-object {
	$first = [int64]$_.split("-")[0]
	$last  = [int64]$_.split("-")[1]	
	if ([int64]$pos   -ge [int64]$first )  { [int64]$first    = [int64]$pos + 1  }
	if ([int64]$first -le [int64]$last )   { [int64]$answer2 += [int64]$last - [int64]$first + 1 }	
	if ([int64]$pos   -lt [int64]$last )   { [int64]$pos      = [int64]$last }
}

Write-host "Part 1 answer:"$answer1                                               # Write the answer to part 1 to the console
Write-host "Part 2 answer:"$answer2                                               # Write the answer to part 2 to the console

# 1,2,3,4,5
#    3,4,5,6,7,8,9
#      4,5,6
#              8,9
