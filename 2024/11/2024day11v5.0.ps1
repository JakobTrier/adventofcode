# By JATR, 2025.11.21
# https://adventofcode.com/2024/day/11#part2
# Version 5.0: PowerShell 7 introduces -Parallel and -ThrottleLimit
# Stored at https://github.com/JakobTrier/adventofcode

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
 $puzzledata = Get-Content 2024day11.dat          
 #$puzzledata = Get-Content 2024day11example.dat  # -> 55312; took 8 seconds

# Declare variables
[bigint[]]$stones = @()
$answer = @()
$blinks = 75

# Start by importing the puzzle data into an array as well as creating a pointer array the same length 
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Importing puzzledata into an array" 
$stones = $puzzledata.split(' ')

write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Starting with $($stones.count) stone(s):"$stones
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "'Blinking'" $blinks "times"

$answer += $stones | ForEach-Object -ThrottleLimit 10 -Parallel {
  function CountStones($stone, $iterations) 
    {
    if ( $iterations -eq 0 )
      { 
		return 1
      } 
    elseif ( $stone -eq 0 ) 
      { 
        return CountStones 1 $($iterations - 1) 
      } 
    elseif ( ([int]([string]$stone).length % 2) -eq 0 ) 
      { 
        $lengthofnumber = ([string]$stone).length
        return (CountStones ([bigint]($stone/[Math]::Pow(10,(($lengthofnumber/2) )))) $($iterations - 1))   +    ( CountStones ([bigint]([string]([string]$stone)[$($lengthofnumber/2)..$($lengthofnumber-1)]).replace(' ' , ''))    $($iterations - 1) )
      } 
    else 
      {
        return CountStones $($stone * 2024) $($iterations - 1)
      }
    }
  $sum = CountStones $_ $using:blinks 
  write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "   Stone with number $($_) becomes $($sum) stones after $($using:blinks) blinks."
  $sum 
} 

Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " ($answer | measure-object -sum ).sum
