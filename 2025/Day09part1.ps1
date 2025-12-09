# By JATR, 2025.12.09
# https://adventofcode.com/2025/day/9

$puzzledata  = Get-Content 2025day09.dat                                          # Load the data, it must be copied from https://adventofcode.com/2025/day/9/input and saved in a file called 2025day09.dat
[int64]$answer1     = 0                                                           # Declare variable used to store answer to part 1

$tiles = $puzzledata.count                                                        # Declare variable to keep number of junction boxes
$bx = @()                                                                         # Declare array used to store x coordinate of tiles
$by = @()                                                                         # Declare array used to store y coordinate of tiles

$puzzledata | foreach-object {
  $bx += $_.split(",")[0]
  $by += $_.split(",")[1]
}

function RectangleSize ($x1,$y1,$x2,$y2) {                                        # Function to calculate the size of rectangle
  return ([Math]::Abs([long]($x1-$x2)) + 1) * ([Math]::Abs([long]($y1-$y2)) + 1)
}
	
for ($i = 0 ; $i -lt $tiles ; $i++) {   
  for ($j = $i+1 ; $j -lt $tiles ; $j++) {   
    $ss = Rectangle Size $bx[$i] $by[$i] $bx[$j] $by[$j]
    if ( $ss -gt $answer1 ) {$answer1=$ss }
  }
}

Write-host "Part 1 answer:"$answer1                                               # Write the answer to part 1 to the console
