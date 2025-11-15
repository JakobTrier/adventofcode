# By JATR, 2025.11.15
# https://adventofcode.com/2024/day/11
# Version 2.0: Let us get rid of the pointers!
# Stored at https://github.com/JakobTrier/adventofcode

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day11.dat 
#$puzzledata = Get-Content 2024day11example.dat  # -> 55312; took 6 minutes and 50 seconds

# Declare variables
[int64[]]$stones = @()
$iterations = 25

# Start by importing the puzzle data into an array as well as creating a pointer array the same length 
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Importing puzzledata into an array" 
$stones = $puzzledata.split(' ')

write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Starting with $($stones.count) stone(s):"$stones
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "'Blinking'" $iterations "time(s)"

for ( $m = 0 ; $m -lt $iterations ; $m++ ) {
  $elements = $stones.count
  for ( $i = 0 ; $i -lt $elements ; $i++ ) {
      if ( $stones[$i] -eq 0 ) {                            # If the stone is engraved with the number 0, 
      $stones[$i] = 1                                     # it is replaced by a stone engraved with the number 1.
    } elseif ( ([string]$stones[$i]).length % 2 -eq 0 ) { # If the stone is engraved with a number that has an even number of digits, it is replaced by two stones
      $part1 = [int64]([string]([string]$stones[$i])[0..$(([string]$stones[$i]).length/2-1)]).replace(' ' , '')
      $part2 = [int64]([string]([string]$stones[$i])[$(([string]$stones[$i]).length/2)..$(([string]$stones[$i]).length-1)]).replace(' ' , '')
      $stones[$i] = [int64]$part1
      $stones += [int64]$part2
    } else {                                                  # If none of the other rules apply, the stone is replaced by a new stone; the old stone's number multiplied by 2024 is engraved on the new stone.
      $stones[$i] = $stones[$i] * 2024
    }
  } 
  write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") " After blinking" $($m+1)"time(s), you would have $($stones.count) stone(s)."
}
Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " $stones.count

