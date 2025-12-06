# By JATR, 2025.12.06
# https://adventofcode.com/2025/day/6

$puzzledata = Get-Content 2025day06.dat                                     # Load the data, it must be copied from https://adventofcode.com/2025/day/6/input and saved in a file called 2025day06.dat
$answer1    = 0                                                             # Declare variable used to store answer 
$answer2    = 0                                                             # Declare variable used to store answer 
$lines      = $puzzledata.count - 1                                         # Number of lines with numbers (3 in example, 4 in puzzle real data)

for ($f = 0 ; $f -le $lines ; $f++) {                                       # As my code looks for the next space (" ") in order to determine how long the next number is 
  $puzzledata[$f]	= $puzzledata[$f] + " "                                 # it was easier to add a space at the end instead of handling the case where there were no spaces lef
}

do {                                                                        # We repeat until we have handled all numbers
  $spacelocation = 0                                                        # We start of not knowing how far away the next space is

  for ($f = 0 ; $f -lt $lines ; $f++) {                                     # Now we find the space find space by looking at all lines with numbers, the one with the space the furthes away wins
    if ($puzzledata[$f].IndexOf(" ") -gt $spacelocation) {
      $spacelocation = $puzzledata[$f].IndexOf(" ")
    }
  }

  $numbers = @()                                                            # This variable is used to store the numbers needed for part 2
  for ($f = 0 ; $f -lt $spacelocation ; $f++) {                             # Here we generate the numbers needed for part 2
    $temp = ""                                                         
    for ($i = 0 ; $i -lt $lines ; $i++) {                                   # We build it up as a string
      $temp += [string]([string]$puzzledata[$i].substring(0,$spacelocation))[$f] 
	}
    $numbers += [int]($temp)                                                # Here we convert each number stored as a string into an integer and put it in the $numbers variable
  }

  if ($puzzledata[$lines].substring(0,$spacelocation).IndexOf("+") -ge 0) { # If the operator is "+" we have to add the numbers
    for ($f = 0 ; $f -lt $lines ; $f++) {                                   # This is for the part 1 answer
      $answer1=$answer1 + [int]$puzzledata[$f].substring(0,$spacelocation) 
    }
    for ($f = 0 ; $f -lt $spacelocation ; $f++) {                           # This is for the part 2 answer
      $answer2 = $answer2 + $numbers[$f]
    }
  } else {                                                                  # We have to multiply (operator must be "*")
    $multi=1 
    for ($f = 0 ; $f -lt $lines ; $f++) {                                   # This is for the part 1 answer
      $multi = $multi * [int]$puzzledata[$f].substring(0,$spacelocation)    # First we multiply all the numbers
    }
	$answer1=$answer1 + $multi                                              # and then we add the result to the answer for part 1
    $multi=1                                                                # Reset for the part 2 answer
    for ($f = 0 ; $f -lt $spacelocation ; $f++) {                           # First we multiply all the numbers
      $multi = $multi * $numbers[$f]
    }
    $answer2=$answer2 + $multi                                              # and then we add the result to the answer for part 2
  }
  
  $spacelocation++                                                          # We prepare to remove the first number + a space from the strings
  for ($f = 0 ; $f -le $lines ; $f++) {                                     # We now remove the numbers and operator we just looked at
	$puzzledata[$f] = $puzzledata[$f].substring($spacelocation,$puzzledata[$f].length-$spacelocation)
  }
} while ( $puzzledata[0].length -ne 0 )                                     # We keep going until the string is empty and all numbers have been handled.

Write-host "Part 1 answer:"$answer1                                         # Write the answer to part 1 to the console 5877594983578
Write-host "Part 2 answer:"$answer2                                         # Write the answer to part 2 to the console  , 5291902 is too low
