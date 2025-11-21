# By JATR, 2025.11.11
# https://adventofcode.com/2024/day/10

function FindRoad([int]$x,[int]$y)
{
	if ([int]$Map[$x,$y] -eq 9) { #end of the road
	  $NewEndPoint = $true
	  for ($m = 0 ; $m -lt $global:EndPointX.length ; $m++) {
	    if ($global:EndPointX[$m] -eq [int]$x -and $global:EndPointY[$m] -eq [int]$y) { $NewEndPoint = $false }
	  }
	  if ( $NewEndPoint ) {
	    $global:EndPointX = $global:EndPointX + [int]$x
	    $global:EndPointY = $global:EndPointY + [int]$y
	    $global:score = $global:score + 1
	  }
	} else {
	  if ((($x + 1) -lt $sizex) -and $([int]($Map[$x,$y] + 1)) -eq [int]$Map[$($x + 1),$y] ) { FindRoad $($x + 1) $y }
	  if (($x -gt 0)            -and $([int]($Map[$x,$y] + 1)) -eq [int]$Map[$($x -1 ),$y] ) { FindRoad $($x - 1) $y }
	  if ((($y + 1) -lt $sizey) -and $([int]($Map[$x,$y] + 1)) -eq [int]$Map[$x,$($y + 1)] ) { FindRoad $x $($y + 1) }
	  if (($y -gt 0)            -and $([int]($Map[$x,$y] + 1)) -eq [int]$Map[$x,$($y - 1)] ) { FindRoad $x $($y - 1) }
	}
}

function FindScore([int]$x,[int]$y) 
{
  # Write-Host "Trailhead found at (" $x "," $y ")"
  $global:score = 0
  $global:EndPointX = @()
  $global:EndPointY = @()
  FindRoad $x $y
  # Write-Host "    Score is " $global:score
}

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day10.dat 

$sizex = $puzzledata[0].length
$sizey = $puzzledata.count
  
# Declare variables
$Map = New-Object -TypeName 'Int[,]' -ArgumentList $sizex,$sizey   # Create the matrix for storing puzzledata 
$answer         = 0                                                # We do not know the answer yet

# Populate Map matrix with data
for ($i = 0 ; $i -lt $sizey ; $i++) { 
  for ($j = 0 ; $j -lt $sizex ; $j++) { 
    [int]$Map[$j,$i] = [string]$puzzledata[$i][$j]
  }
}
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Counting..." 
# Check all trailheads

for ($i = 0 ; $i -lt $sizey ; $i++) { 
  for ($j = 0 ; $j -lt $sizex ; $j++) { 
    if ( $Map[$j,$i] -eq 0) {
		FindScore $j $i
		$answer = $answer + $global:score
	}
  }
}

Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " $answer



