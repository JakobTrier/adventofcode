# By JATR, 2025.11.14
# https://adventofcode.com/2024/day/11
# Version 1.0: Keeping the order
# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day11.dat 
# $puzzledata = Get-Content 2024day11example.dat  # -> 55312; took 8½ minutes in PowerShell 5.1.22621.6060, 27 minutes in PowerShell 7.5.4

# Declare variables
[int64[]]$pointer = @()
[int64[]]$stones = @()
$iterations = 25

# Start by importing the puzzle data into an array as well as creating a pointer array the same length 
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Importing puzzledata into an array" 
$stones = $puzzledata.split(' ')
for ( $i = 0 ; $i -lt $stones.count - 1 ; $i++ ) {
   $pointer += $i + 1
}
$pointer += -1 # indicate end of data

write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Starting with $($stones.count) stone(s):"$stones
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "'Blinking'" $iterations "time(s)"

for ( $m = 0 ; $m -lt $iterations ; $m++ ) {
  $element = 0 # we start looking at the first element
  $EndOfData = $false
  while ( $EndOfData -eq $false ) {
    if ( $pointer[$element] -eq -1 ) { $EndOfData = $true }   # last line has been reached.
    if ( $stones[$element] -eq 0 ) {                            # If the stone is engraved with the number 0, 
      $stones[$element] = 1                                     # it is replaced by a stone engraved with the number 1.
    } elseif ( ([string]$stones[$element]).length % 2 -eq 0 ) { # If the stone is engraved with a number that has an even number of digits, it is replaced by two stones
      $part1 = [int64]([string]([string]$stones[$element])[0..$(([string]$stones[$element]).length/2-1)]).replace(' ' , '')
      $part2 = [int64]([string]([string]$stones[$element])[$(([string]$stones[$element]).length/2)..$(([string]$stones[$element]).length-1)]).replace(' ' , '')
      $stones[$element] = [int64]$part1
      $stones += [int64]$part2
      $pointer += $pointer[$element]
      $pointer[$element] = $pointer.count - 1
      $element=$pointer[$element]                             # We skip one stone because a new one just appeared (which we should not look at now)
    } else {                                                  # If none of the other rules apply, the stone is replaced by a new stone; the old stone's number multiplied by 2024 is engraved on the new stone.
      $stones[$element] = $stones[$element] * 2024
    }
    $element=$pointer[$element] # Let us look at the next "stone"
  } 
  write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") " After blinking" $($m+1)"time(s), you would have $($stones.count) stone(s)."
}
Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " $stones.count

