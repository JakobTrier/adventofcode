# By JATR, 2025.11.24
# https://adventofcode.com/2024/day/12

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day12.dat 

$sizex      = $puzzledata[0].length
$sizey      = $puzzledata.count
  
# Declare variables
$Map        = New-Object -TypeName 'Char[,]' -ArgumentList $sizex,$sizey   # Create the matrix for storing puzzledata 
$global:AllAreas   = New-Object -TypeName 'Char[,]' -ArgumentList $sizex,$sizey   # Create the matrix for storing info on already identified areas 
$answer     = 0   

# Populate Map matrix with data
for ($i = 0 ; $i -lt $sizey ; $i++) { 
  for ($j = 0 ; $j -lt $sizex ; $j++) { 
    [Char]$Map[$j,$i] = [string]$puzzledata[$i][$j]
  }
}

function FindArea([int]$x,[int]$y)
{
  $global:AllAreas[$x,$y] = 'X'   # Mark this spot as part of an already found area.
  $global:NewArea[$x,$y] = 'X'   # Mark this spot as part of an already found area in the NewArea map
  $global:area = $global:area + 1
  if (($Map[$x,$y] -ne $Map[$($x + 1),$y]) -or (($x + 1) -eq $sizex))  { $global:perimter++ }
  if (($Map[$x,$y] -ne $Map[$x,$($y + 1)]) -or (($y + 1) -eq $sizey)) { $global:perimter++ }
  if (($Map[$x,$y] -ne $Map[$($x -1 ),$y]) -or ($x -eq 0)) { $global:perimter++ }
  if (($Map[$x,$y] -ne $Map[$x,$($y - 1)]) -or ($y -eq 0)) { $global:perimter++ }
  if ((($x + 1) -lt $sizex) -and $(($Map[$x,$y])) -eq $Map[$($x + 1),$y] -and $global:AllAreas[$($x + 1),$y] -ne 'X') { FindArea $($x + 1) $y }
  if ((($y + 1) -lt $sizey) -and $(($Map[$x,$y])) -eq $Map[$x,$($y + 1)] -and $global:AllAreas[$x,$($y + 1)] -ne 'X') { FindArea $x $($y + 1) }
  if (($x -gt 0)            -and $(($Map[$x,$y])) -eq $Map[$($x -1 ),$y] -and $global:AllAreas[$($x -1 ),$y] -ne 'X') { FindArea $($x - 1) $y }
  if (($y -gt 0)            -and $(($Map[$x,$y])) -eq $Map[$x,$($y - 1)] -and $global:AllAreas[$x,$($y - 1)] -ne 'X') { FindArea $x $($y - 1) }
}

function CalculateSides
{
# check all cells on the map one by one
for ($i = 0 ; $i -lt $sizey ; $i++) {
  $previouswasx = $false	
  for ($j = 0 ; $j -lt $sizex ; $j++) { 
    if  ($NewArea[$j,$i] -eq 'X' -and (($NewArea[$j,$i] -ne $NewArea[$j,$($i - 1)]) -or ($i -eq 0))) { # We found a spot/X with an edge above it....
       if ( $previouswasx -eq $true ) {
		    $global:sides = $global:sides -1
	   }
	   $previouswasx = $true
    } else {
		$previouswasx = $false
	}
   }
}

for ($i = 0 ; $i -lt $sizey ; $i++) {
  $previouswasx = $false	
  for ($j = 0 ; $j -lt $sizex ; $j++) { 
    if  ($NewArea[$j,$i] -eq 'X' -and (($NewArea[$j,$i] -ne $NewArea[$j,$($i + 1)]) -or (($i + 1) -eq $sizey))) { # We found a spot/X with an edge below it....
       if ( $previouswasx -eq $true ) {
		    $global:sides = $global:sides -1
	   }
	   $previouswasx = $true
    } else {
		$previouswasx = $false
	}
   }
}

for ($i = 0 ; $i -lt $sizex ; $i++) {
  $previouswasx = $false	
  for ($j = 0 ; $j -lt $sizey ; $j++) { 
    if  ($NewArea[$i,$j] -eq 'X' -and (($NewArea[$i,$j] -ne $NewArea[$($i - 1),$j]) -or ($i -eq 0))) { # We found a spot/X with an edge left of it....
       if ( $previouswasx -eq $true ) {
		    $global:sides = $global:sides -1
	   }
	   $previouswasx = $true
    } else {
		$previouswasx = $false
	}
   }
}

for ($i = 0 ; $i -lt $sizex ; $i++) {
  $previouswasx = $false	
  for ($j = 0 ; $j -lt $sizey ; $j++) { 
    if  ($NewArea[$i,$j] -eq 'X' -and (($NewArea[$i,$j] -ne $NewArea[$($i + 1),$j]) -or (($i + 1) -eq $sizex))) { # We found a spot/X with an edge right of it....
       if ( $previouswasx -eq $true ) {
		    $global:sides = $global:sides -1
	   }
	   $previouswasx = $true
    } else {
		$previouswasx = $false
	}
   }
}
}

# Check map for areas
for ($i = 0 ; $i -lt $sizey ; $i++) { 
  for ($j = 0 ; $j -lt $sizex ; $j++) { 
    if ( $global:AllAreas[$j,$i] -ne 'X' ) {
	  $global:area     = 0
	  $global:perimter = 0
	  $global:NewArea    = New-Object -TypeName 'Char[,]' -ArgumentList $sizex,$sizey   # Create the matrix for storing info on the most recently found area - used to calculate number of sides
	  FindArea $j $i
	  $global:sides    = $global:perimter
	  CalculateSides
	  $answer=$answer + $global:area * $global:sides
	}
  }
}

write-host "Answer: " $answer
