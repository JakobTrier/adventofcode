# By JATR, 2025.12.03
# https://adventofcode.com/2025/day/3

function TenToThePowerOf ( $exp ) {                                            # Function to return 10^exp for intergers in the range 0..11 to save time not calculating it when needed
  switch ($exp) {
  0  { return 1 }
  1  { return 10 }
  2  { return 100 }
  3  { return 1000 }
  4  { return 10000 }
  5  { return 100000 }
  6  { return 1000000 }
  7  { return 10000000 }
  8  { return 100000000 }
  9  { return 1000000000 }
  10 { return 10000000000 }
  11 { return 100000000000 }                                                   # Almost looks like a Xmas tree - what joy! :-D
  }
}

function FindNumber ([string]$line,[int]$x,[int]$digits) {                       # Recursive function using memoisation to find the largest 12 digit number in a line
  if ($x -eq $line.Length -and $digits -eq 12) {
    return 0
  }
  if ($x -eq $line.Length) {            # use a large negative integer 
    return -1000000000000               # -10^12
  }
  $key = "$x`|$digits"
  if ($global:cache.ContainsKey($key)) {
   return $global:cache[$key]
  }
  # Option 1: skip current character
  $n = FindNumber $line ($x + 1) $digits 
  # Option 2: take current digit if we still can
  if ($digits -lt 12) {
    $value = (TenToThePowerOf (11 - $digits)) * ( [int][string]$line[$x] ) +  $(FindNumber $line ($x + 1) ($digits + 1)  )    # Calculate 10^(11-used) * digit 
    if ($value -gt $n) { $n = $value }
  }
  $global:cache[$key] = $n
  return $n
}

[bigint]$answer1  = 0                                                             # Declare variable used to store answer to part 1
[bigint]$answer2  = 0                                                             # Declare variable used to store answer to part 2
 
$puzzledata = Get-Content 2025day03.dat

$puzzledata | foreach {                                                
  $max = 0							
  for ( $i = 0 ; $i -lt $($_.length-1) ; $i++ ) {
    for ( $j = ($i+1) ; $j -lt $_.length ; $j++ ) {
        $newnumber = $(([int][string]$_[$i]) *10 +  [int][string]$_[$j] )
        if ( $newnumber -gt $max ) { $max = $newnumber }
    }
  }
  $answer1 = $answer1 + $max
  
  $global:cache = @{}                                                             # (Re)initialize cache used for memoisation
  $answer2 = $answer2 + (FindNumber $_ 0 0 ) 
  
}

Write-host "Part 1 answer:"$answer1
Write-host "Part 2 answer:"$answer2
