# By JATR, 2025.12.07
# https://adventofcode.com/2025/day/7

$puzzledata = Get-Content 2025day07.dat                                     # Load the data, it must be copied from https://adventofcode.com/2025/day/7/input and saved in a file called 2025day07.dat
$answer1    = 0                                                             # Declare variable used to store answer 
$answer2    = 0                                                             # Declare variable used to store answer 

$sizex = $puzzledata[0].length                                              # Get the width of the puzzle data
$sizey = $puzzledata.count                                                  # Get the height of the puzzle data

$Map  = New-Object -TypeName 'Char[,]' -ArgumentList $sizex,$sizey          # Create the matrix for storing puzzledata 
$Map2 = New-Object -TypeName 'Int64[,]' -ArgumentList $sizex,$sizey         # Create the matrix for storing data used to solve part 2

for ($i = 0 ; $i -lt $sizey ; $i++) {                                       
  for ($j = 0 ; $j -lt $sizex ; $j++) { 
    $Map[$j,$i] = $puzzledata[$i][$j]                                       # Populate Map matrix with data
  }
}

if ( $puzzledata[0].IndexOf("S") -ne -1 ) {                                 # We assume the S sign is in the first line
  $posx = $puzzledata[0].IndexOf("S")	                                      # Store the x position of the S sign 
  $Map[$posx,1]  = '|'                                                      # Add the initial beam used for part 1
  $Map2[$posx,1] = 1                                                        # Add initial number of timelines for part 2
}

for ($y = 2 ; $y -lt $sizey ; $y++ ) {                                      # Start at the 3rd line (y=2) and run throgh all lines
  for ($x = 0 ; $x -lt $sizex ; $x++ ) {                                    # Examine one position at the time on each line
    if ( $Map[$x,$y] -eq '^' -and $Map[$x,($y-1)] -eq '|') {                # If we see a ^ and there is a beam (|) above the beam will split
      $answer1++                                                            # Adding 1 to answer1 as the beam has split once more
      $Map[$($x-1),$y] = '|'                                                # Making sure that there is a beam to the left of the splitter 
      $Map[$($x+1),$y] = '|'                                                # Making sure that there is a beam to the right of the splitter (even if there is one already)
      $Map2[$($x-1),$y] += $Map2[$x,$($y-1)]                                # In the $Map2 matrix we store the number of paths to reach this point (left beam)
      $Map2[$($x+1),$y] += $Map2[$x,$($y-1)] 	                              # In the $Map2 matrix we store the number of paths to reach this point (right beam)
    }
    if (  $Map[$x,$($y-1)] -eq '|'){                                        # If there is a beam above us..
      if ($Map[$x,$y] -eq '.') { $Map[$x,$y] = '|' }                        # If we have not yet drawn a beam on this row at this postion we do so
      $Map2[$x,$y] += $Map2[$x,$($y-1)] 	                                  # No matter if there is beam here or not we add the number of paths from the call above to this point
    }
  }
}

for ($x = 0 ; $x -lt $sizex ; $x++ ) {                                      # Calculate part 2 answer by adding up all the possible paths for each beam in the bottom row
  $answer2 += $Map2[$x,$($sizey-1)]
}

for ( $y = 0 ; $y -lt $sizey;$y++ ) {                                       # Print the Xmas tree :)
  for ($x = 0; $x -lt $sizex ; $x++ ) {
    switch ( $map[$x,$y] ) {
      "S" { $color = 'yellow' }                                             # The S(tar) must be yellow!
	    "." { $color = 'white' }                                              # The background will be white
      "|" { $color = 'darkgreen' }                                          # The tree will be dark green
      "^" { $rand =  $(get-random -minimum 0 -maximum 4)                    # The color of the ornaments will be randomized blue, red or magenta
	        if ($rand -eq 0) { 
			  $color = 'darkblue' 
			} elseif ($rand -eq 1) {
			  $color = 'darkred'
			} else {
			  $color = 'darkmagenta' 
			}
          }
    }
    write-host $map[$x,$y] -nonewline -foregroundcolor $color -backgroundcolor white 
  }
  write-host ""
}

Write-host "Part 1 answer:"$answer1                                         # Write the answer to part 1 to the console
Write-host "Part 2 answer:"$answer2                                         # Write the answer to part 2 to the console
