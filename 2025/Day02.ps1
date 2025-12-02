# By JATR, 2025.12.02
# https://adventofcode.com/2025/day/2

$puzzledata = Get-Content 2025day02.dat                                           # Load the data
										                                          
[bigint]$answer1  = 0                                                             # Declare variable used to store answer to part 1
[bigint]$answer2  = 0                                                             # Declare variable used to store answer to part 2
$idranges = @()                                                                   # Declare variable used to store all ID ranges
$ids = $()                                                                        # Declare variable used to store IDs when examining a range
										                                          
$idranges = $puzzledata.split(",")                                                # First lets populate the idranges variable with all the ranges
										                                          
$idranges | foreach {                                                             # Let us look at each range one at the time
  $ids = $_.split("-")                                                            # We put the first and last ID in the ids variable
																			      
  for ( $i = 0 ; $i -le ( $ids[1] - $ids[0]) ; $i++ ) {                           # Loop through all the IDs in the range from $ids[0] to $ids[1]
    $string = [string]$([bigint]$ids[0] + $i)                                     # Convert the number to examine in the range to a string
																			      
	     # This is for the part 1 answer                                          
	if (($string.Length % 2) -eq 0) {                                               # Only evaluate the number if it has an even number of numbers like 11, 2222 or 333333
      $half = [int]($string.Length / 2)                                           # Calculate half the length of the string/number as we need to use this number several times soon
      if ($string.Substring(0, $half) -eq $string.Substring($half, $half)) {      # Check if the first half of the string/number is identical to the last part
        [bigint]$answer1 = [bigint]$answer1 + $([bigint]$ids[0] + $i)	            # If the two parts are identical then add the number to the total answer1
      }                                                                           
    }                                                                             
																			      
       # This is for the part 2 answer                                            
    for ( $k = 2 ; $k -le $string.length ; $k++) {                                # Now we have to try and divide the number in not only 2 chuncks. 
      if (($string.length % $k) -eq 0) {                                          # Only evaluate the number if it can be cut in equally sized chuncks
        $invalid = $true                                                          # We start off assuming the number IS invalid, and if we find chuncks not identical we change our mind
        $chunck = [int]($string.length / $k)                                      # Determine the size of the chuncks to check
        for ($j = $chunck ; $j -lt $string.length ; $j = $j + $chunck) {          # Loop through all the chuncks
          if ($string.substring(0, $chunck) -ne $string.substring($j, $chunck)) { # We check if the first chunck is different from any other chuck
            $invalid = $false                                                     # and if it is then we know the number is not invalid with the examined chunck size, but maybe with another
            $j = $string.length                                                   # stop the for loop, no need to compare other chuncks to the first one. This will save us some time (16 sec on my laptop)
          }
        }
        if ($invalid) {                                                           # If the invalid variable is still true we have found an invalid number
          [bigint]$answer2 = [bigint]$answer2 + $([bigint]$ids[0] + $i)           # If the all parts are identical then add the number to the total answer2
          $k = $string.Length                                                     # stop the for loop, we should not try other chunck sizes, let us move on to the next number in the range
        }
      }
    }	   
  }   
}
Write-host "Part 1 answer:"$answer1
Write-host "Part 2 answer:"$answer2
