# By JATR, 2025.11.12
# https://adventofcode.com/2024/day/11#part2
# Version 7.0: Memoisation with -Parallel. Next: How to share cache between parallel threads
# Stored at https://github.com/JakobTrier/adventofcode

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day11.dat          
# $puzzledata = Get-Content 2024day11example.dat  # -> 55312; took 100 ms 

# Declare variables
[bigint[]]$stones = @()
$global:CountStonesCache = @{} # initialize cache 
$answer = 0
$blinks = 75

# Start by importing the puzzle data into an array as well as creating a pointer array the same length 
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Importing puzzledata into an array" 
$stones = $puzzledata.split(' ')

write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Starting with $($stones.count) stone(s):"$stones
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "'Blinking'" $blinks "times"

$result = @()
$result += $stones  | ForEach-Object -ThrottleLimit 10 -Parallel {
	
$global:CountStonesCache = @{} # initialize cache      !! what happens if I move it outside the loop?
function CountStones($stone, $iterations) 
{
  # build cache key
  $key = "$stone`|$iterations"
  if ($global:CountStonesCache.ContainsKey($key)) {
    return $global:CountStonesCache[$key]
  }
	
  if ( $iterations -eq 0 )
  { 
	$n = 1
  } 
  elseif ( $stone -eq 0 ) 
  { 
    $n =  CountStones 1 $($iterations - 1) 
  } 
  elseif ( ([int]([string]$stone).length % 2) -eq 0 ) 
  { 
      $lengthofnumber = ([string]$stone).length
      $n = (CountStones ([bigint]($stone/[Math]::Pow(10,(($lengthofnumber/2) )))) $($iterations - 1))   +    ( CountStones ([bigint]([string]([string]$stone)[$($lengthofnumber/2)..$($lengthofnumber-1)]).replace(' ' , ''))    $($iterations - 1) )
  } 
  else 
  {
      $n = CountStones $($stone * 2024) $($iterations - 1)
  }
 # store in cache and return
  $global:CountStonesCache[$key] = $n
  return $n 
}
	$sum = CountStones $_ $using:blinks 
	write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "   Stone with number $($_) becomes $($sum) stones after $($using:blinks) blinks."
	[bigint]$sum
}

Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: "($result | measure-object -sum ).sum












