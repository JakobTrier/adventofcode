# By JATR, 2025.11.15
# https://adventofcode.com/2024/day/11
# Version 3.0: A new way to calculate first and second half of number being split
# Stored at https://github.com/JakobTrier/adventofcode

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day11.dat 
# $puzzledata = Get-Content 2024day11example.dat  # -> 55312; took 6 minutes and 14 seconds

# Declare variables
[int64[]]$data = @()
$iterations = 25

# Start by importing the puzzle data into an array as well as creating a pointer array the same length 
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Importing puzzledata into an array" 
$data = $puzzledata.split(' ')

write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Starting with $($data.count) stone(s):"$data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "'Blinking'" $iterations "time(s)"

for ( $m = 0 ; $m -lt $iterations ; $m++ ) {
  $elements = $data.count
  for ( $i = 0 ; $i -lt $elements ; $i++ ) {
      if ( $data[$i] -eq 0 ) {                            # If the stone is engraved with the number 0, 
        $data[$i] = 1                                     # it is replaced by a stone engraved with the number 1.
    } elseif ( ([string]$data[$i]).length % 2 -eq 0 ) { # If the stone is engraved with a number that has an even number of digits, it is replaced by two stones
        $half = ([string]$data[$i]).length/2
        $part1 = [bigint]($data[$i]/[Math]::Pow(10,(($half) )))
 	    $s = [string]$data[$i]
        $lengthofnumber = ([string]$data[$i]).Length
        $rightStr = $s[$half..($lengthofnumber - 1)] -join ''
        $part2 = if ($rightStr -eq '') { 0 } else { [bigint]::Parse($rightStr) }
        $data[$i] = [int64]$part1
        $data += [int64]$part2
    } else {                                                  # If none of the other rules apply, the stone is replaced by a new stone; the old stone's number multiplied by 2024 is engraved on the new stone.
      $data[$i] = $data[$i] * 2024
    }  
  } 
  write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") " After blinking" $($m+1)"time(s), you would have $($data.count) stone(s)."
}
Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " $data.count

