# By JATR, 2025.12.01
# https://adventofcode.com/2025/day/1

$puzzledata = Get-Content 2025day01.dat   # Load the data

$answer1  = 0                             # Declare variable used to store answer to part 1
$answer2  = 0                             # Declare variable used to store answer to part 2
$location = 50                            # Start location

$puzzledata | foreach {
$distance =	[int]$_.substring(1)          # Read if we should turn Left or Right
if ( $_[0] -eq 'R' ){                     # Turn right
  for ($i = 0 ;$i -lt $distance ; $i++) { # Move the dial one step at the time
     $location = ($location + 1) % 100    # Determine the new location after one move
     if ($location -eq 0 ) { $answer2++}  # If we are at 0 add to answer 2
  }
} else {                                  # Turn left 
  for ($i = 0 ;$i -lt $distance ; $i++) { # Move the dial one step at the time
     $location = ($location - 1) % 100    # Determine the new location after one move (we do not care if we are at a negative spot)
	   if ($location -eq 0 ) { $answer2++}  # If we are at 0 add to answer 2
  }
}
if ($location -eq 0 ) { $answer1++}       # If we after a move are at 0 add to answer 1
}
Write-host "Part 1 answer:"$answer1
Write-host "Part 2 answer:"$answer2
