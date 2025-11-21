# By JATR, 2025.11.06
# https://adventofcode.com/2024/day/14#part2

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

 for ($iterations = 0 ; $iterations -lt 100000 ; $iterations++ ) {

  # Create the matrix for storing the location of the robots (per default all cells in the Matrix seem to have value 0)
  $Map = New-Object -TypeName 'Int[,]' -ArgumentList $sizex,$sizey

  # Let us calculate the location of the robots after $iterations iterations
  for ($i = 0 ; $i -lt $puzzledata.count ; $i++) {  
   $posx = ( $RobotInfo[$i,0] + $RobotInfo[$i,2] * $iterations ) % $sizex
   $posy = ( $RobotInfo[$i,1] + $RobotInfo[$i,3] * $iterations ) % $sizey
   if ($posx -lt 0) {$posx = $posx + $sizex}
   if ($posy -lt 0) {$posy = $posy + $sizey}
   $Map[$posx,$posy]=$Map[$posx,$posy] + 1
  }

  # Let us look at how many robots are placed in the "center" of the map
  $q1 = 0
  for ( $x = 48 ; $x -lt  53 ; $x++ ) {
   for ( $y = 48 ; $y -lt 53  ; $y++ ) {
    $q1 = $q1 + [int]$Map[$x,$y]
   }
  }
  # write-host $iterations " : " $q1
  if ( $q1 -gt 15 ) {
	write-host "Look at this: " $iterations
	
    # Print the Map.....

    for ($ky = 0; $ky -lt $sizey ; $ky++){
    $line = $null	
    for ($kx = 0; $kx -lt $sizex ; $kx++){
	  $line = $line + [string]$Map[$kx,$ky]
    }
    Write-host $line.replace('0','.').replace('1','X')
  }
 }
}

# $iterations = 7584
