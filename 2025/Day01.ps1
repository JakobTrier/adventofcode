# By JATR, 2025.12.01
# https://adventofcode.com/2025/day/1

$puzzledata = Get-Content 2025day01.dat   # Load the data, it must be copied from https://adventofcode.com/2025/day/1/input and saved in a file called 2025day01.dat

$answer1  = 0                             # Declare variable used to store answer to part 1
$answer2  = 0                             # Declare variable used to store answer to part 2
$location = 50                            # Start location

$puzzledata | foreach {                   # Let us look at each line of the puzzle data, one by one
$distance =	[int]$_.substring(1)          # Store how far we should move either left or right in the variable called $distance
if ( $_[0] -eq 'R' ){                     # Read if we should turn Right
  for ($i = 0 ;$i -lt $distance ; $i++) { # Move the dial one step at the time to the Right (+)
     $location = ($location + 1) % 100    # Determine the new location after one move
     if ($location -eq 0 ) { $answer2++}  # If we are at 0 add to answer2
  }
} else {                                  # If we should not turn Right then it must be Left 
  for ($i = 0 ;$i -lt $distance ; $i++) { # Move the dial one step at the time to the Left (-)
     $location = ($location - 1) % 100    # Determine the new location after one move (we do not care if we are at a negative spot)
     if ($location -eq 0 ) { $answer2++}  # If we are at 0 add to answer2
  }
}
if ($location -eq 0 ) { $answer1++}       # If we after a move are at 0 add to answer1
}
Write-host "Part 1 answer:"$answer1
Write-host "Part 2 answer:"$answer2
