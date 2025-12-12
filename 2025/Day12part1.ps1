# By JATR, 2025.12.12
# https://adventofcode.com/2025/day/12

$puzzledata         = Get-Content 2025day12.dat                                # Load the data, it must be copied from https://adventofcode.com/2025/day/12/input and saved in a file called 2025day12.dat
$maybeanswer1       = 0                                                        # Declare variable used to store possible answers to part 1
$notanswer1         = 0                                                        # Declare variable used to store number of inputs which will not add to the answer in part 1
$difficultones      = 0                                                        # Declare variable used to store number of difficult to handle inputs in part 1
$giftsizes          = @()                                                      # Declare array for gift sizes
$numberofgiftshapes = 0                                                        # Declare variable used to store number of gift shapes

$puzzledata | foreach-object {                                                 # Find number of gifts
  if ( $_.contains(":") -and -not $_.contains("x") ) { $numberofgiftshapes++ }
}

for ( $gifts = 0 ; $gifts -lt $numberofgiftshapes ; $gifts++ ) {               # Find size of each gift and store it in the $giftsizes array
  $temp = 0
  for ( $i = 0 ; $i -lt 5; $i++ ) {
    $temp += ([regex]::Matches($puzzledata[$(5*$gifts+$i)], "#" )).count
  }
  $giftsizes += $temp                                                          # New giftsize added to the $giftsizes array
}

$puzzledata | foreach-object {                                                 # Check each tree
  if ( $_.contains(":") -and $_.contains("x") ) {                              # If we have a line with tree info in it
    $treesize = $($([int]$_.split(":")[0].split("x")[0]) * $([int]$_.split(":")[0].split("x")[1]))  # Calculate the size available under the tree
    $nicetreesize = $([math]::truncate($([int]$_.split(":")[0].split("x")[0])/3)) * $([math]::truncate($([int]$_.split(":")[0].split("x")[1])/3)) * 9 # Calcuate space for 3x3 packages 
    $currentgiftsize = 0
    for ( $i=0 ; $i -lt $numberofgiftshapes ; $i++) {                          # Calculate how much space all gifts will need as a minimum
      $currentgiftsize += $([int]$_.split(":")[1].split(" ")[$($i+1)]) * $giftsizes[$i]
    }
    if ( $nicetreesize -ge $currentgiftsize ) {                                # Check if there is space enough under the tree for all the gifts if sized 3x3
      $maybeanswer1++                                                          # If it is the case then this line is GOOD
    } elseif ($currentgiftsize -gt $treesize ) {                               # Check if all packages are certainly NOT fitting under the tree
      $notanswer1++                                                            # Counting the number of trees that will not be GOOD
    } else {                                                                   # Last case is that the packages have to be placed in some complex manner....
      $difficultones++                                                         # Count the number of these difficult cases and let us hope that there are not too many...
      write-host $_ "---> " -nonewline                                         # Print to console the difficult one...
      write-host $treesize ">" $currentgiftsize ">" $nicetreesize              # and a bit more info about the difficult one....
    }
  }
}
# There are 3 types of input lines:
# 1) Lines where we are sure that the packages can not fit because the size of all the packages is larger than the space available under the tree ($notanswer1)
# 2) Lines where we are sure that the packages can fit because the size of the area under the tree will fit #number_of_packages 3x3 sized packages
# 3) The difficult ones were there is space enough to fit all the packages but we are not sure how to rotate them....

if ( $difficultones -eq 0 ) {                                                  # I guess it was my lucky day :-D
  Write-host "Part 1 answer:"$maybeanswer1                                     # Write the answer to part 1 to the console
} else {
  Write-host "Not yet sure how to determine if the" $difficultones "difficult inputs are okay or not. The answer to part 1 is between" $maybeanswer1 "and" $($maybeanswer1 + $difficultones)
}
