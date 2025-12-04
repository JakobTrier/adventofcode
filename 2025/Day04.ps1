# By JATR, 2025.12.04
# https://adventofcode.com/2025/day/4

$puzzledata            = Get-Content 2025day04.dat                                # Load the data, it must be copied from https://adventofcode.com/2025/day/4/input and saved in a file called 2025day04.dat
[int]$answer1          = 0                                                        # Declare variable used to store answer 
[int]$answer2          = 0                                                        # Declare variable used to store answer 
[boolean]$answer1found = $false                                                   # Declare variable used to store if the first answer has been found  
[boolean]$removedsome  = $true                                                    # declare variable used to loop through the data to find the second answer
[int]$sizex            = $puzzledata[0].length                                    # Determine the width of the map
[int]$sizey            = $puzzledata.length                                       # Determine the height of the map

$Map                   = New-Object -TypeName 'Char[,]' -ArgumentList $($sizex+2),$($sizey+2) # Create the map/matrix for storing puzzledata, add edges(+2,+2)

for ($i =1 ; $i -le $sizex ; $i++) {                                              # Run through all the positions ...
  for ($j =1 ; $j -le $sizey ; $j++ ) {                                           #  ... in each line of the map ...
  $Map[$i,$j] = $puzzledata[$j-1][$i-1]                                           #  ... and populate the map with data...
  }
}                                                                                 # Now data is easily accessable
                                                                 
while ( $removedsome ) {
  $removedsome = $false                                                           # We will stop the while loop the next time if nothing is removed 
  for ($i = 1 ; $i -lt ($sizex+1) ; $i++) {                                       # Run through all positions on the map
    for ($j = 1 ; $j -lt ($sizey+1) ; $j++ ) {
      if ( $Map[$i,$j] -eq '@' ) {                                                # Paper roll found at current position
        $nearbyrolls = 0                                                          # Reset counter of number of nearby paper rolls
        if ( $Map[($i+1),$j] -eq '@' ) { $nearbyrolls++ }                         # This and the next 8 lines check all 8 areas around us and count the number of rolls found
        if ( $Map[($i-1),$j] -eq '@' ) { $nearbyrolls++ }
        if ( $Map[$i,($j+1)] -eq '@' ) { $nearbyrolls++ }
        if ( $Map[$i,($j-1)] -eq '@' ) { $nearbyrolls++ }
        if ( $Map[($i+1),($j+1)] -eq '@' ) { $nearbyrolls++ }
        if ( $Map[($i+1),($j-1)] -eq '@' ) { $nearbyrolls++ }
        if ( $Map[($i-1),($j+1)] -eq '@' ) { $nearbyrolls++ }
        if ( $Map[($i-1),($j-1)] -eq '@' ) { $nearbyrolls++ }
        if  ( $nearbyrolls -lt 4 ) {                                              # If less than 4 paper rolls were found
          $answer1++                                                              # We add the the answer of part 1 
	      if ( $answer1found ) {                                                  # This is my way of ensuring part 1 is answered before I try to work on part 2
		    $Map[$i,$j] = 'x'                                                     # Replace the paper roll (@) with an indication it has been removed (x)
			$answer2++                                                            # Counting the number of replaced paper rolls for part 2
          }
	      $removedsome = $true                                                    # Making sure we loop once more now that we found some paper rolls to remove
        }
      }
    }
  }
  if ( $answer1found -eq $false ) {                                               # First loop done and we know the answer to part 1
    $answer1found = $true                                                         # From now on focus on part 2
	Write-host "Part 1 answer:"$answer1                                           # Write the answer to part 1 to the console
  }
}

Write-host "Part 2 answer:"$answer2                                               # Write the answer to part 2 to the console
