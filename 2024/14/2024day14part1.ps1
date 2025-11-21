# By JATR, 2025.11.06
# https://adventofcode.com/2024/day/14

# Load the data
$puzzledata = Get-Content 2024day14.dat

# Create the matrix for storing puzzledata ( $puzzledata.count = number of robots )
$RobotInfo = New-Object -TypeName 'Int[,]' -ArgumentList $puzzledata.count,4

# Lets populate the matrix with data...
for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
  $RobotInfo[$i,0] = $puzzledata[$i].split(" ")[0].split("=")[1].split(",")[0]  # p x
  $RobotInfo[$i,1] = $puzzledata[$i].split(" ")[0].split("=")[1].split(",")[1]  # p y
  $RobotInfo[$i,2] = $puzzledata[$i].split(" ")[1].split("=")[1].split(",")[0]  # v x
  $RobotInfo[$i,3] = $puzzledata[$i].split(" ")[1].split("=")[1].split(",")[1]  # v y
}
# Now data is easily accessable...

# Size of the matrix defined in the puzzle:
$sizex = 101 # 11
$sizey = 103 # 7

# Create the matrix for storing the location of the robots (per default all cells in the Matrix seem to have value 0)
$Map = New-Object -TypeName 'Int[,]' -ArgumentList $sizex,$sizey

$iterations = 100
# Let us calculatr the location of the robots after 100 iterations
for ($i = 0 ; $i -lt $puzzledata.count ; $i++) {  
  $posx = ( $RobotInfo[$i,0] + $RobotInfo[$i,2] * $iterations ) % $sizex
  $posy = ( $RobotInfo[$i,1] + $RobotInfo[$i,3] * $iterations ) % $sizey
  if ($posx -lt 0) {$posx = $posx + $sizex}
  if ($posy -lt 0) {$posy = $posy + $sizey}
  write-host "Robot " $i " (" $posx "," $posy ")"
  $Map[$posx,$posy]=$Map[$posx,$posy] + 1
}

for ($k = 0; $k -lt 7 ; $k++){
  Write-host $Map[0,$k]$Map[1,$k]$Map[2,$k]$Map[3,$k]$Map[4,$k]$Map[5,$k]$Map[6,$k]$Map[7,$k]$Map[8,$k]$Map[9,$k]$Map[10,$k]
}

# quadrant 1 
$q1 = 0
for ( $x = 0 ; $x -lt ($sizex - 1)/2 ; $x++ ) {
 for ( $y = 0 ; $y -lt ($sizey - 1)/2 ; $y++ ) {
  $q1 = $q1 + [int]$Map[$x,$y]
 }
}

# quadrant 2
$q2 = 0
for ( $x = ($sizex - 1)/2 + 1 ; $x -lt $sizex ; $x++ ) {
 for ( $y = 0 ; $y -lt ($sizey - 1)/2 ; $y++ ) {
  $q2 = $q2 + [int]$Map[$x,$y]
 }
}

# quadrant 3 
$q3 = 0
for ( $x = ($sizex - 1)/2 + 1 ; $x -lt $sizex ; $x++) {
 for ( $y = ($sizey - 1)/2 + 1 ; $y -lt $sizey  ; $y++ ) {
  $q3 = $q3 + [int]$Map[$x,$y]
 }
}

# quadrant 4 
$q4 = 0
for ( $x = 0 ; $x -lt ($sizex - 1)/2 ; $x++) {
 for ( $y = ($sizey - 1)/2 + 1 ; $y -lt $sizey  ; $y++ ) {
  $q4 = $q4 + [int]$Map[$x,$y]
 }
}

Write-Host "Answer: " $q1*$q2*$q3*$q4 " = " $($q1*$q2*$q3*$q4)

