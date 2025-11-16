# By JATR, 2025.08.26
# https://adventofcode.com/2024/day/2#part2

# A function to check if a line contains safe data according to the day2part1 definition
function SafeDataCheck {
    param (
        [string[]]$DataString
    )
    foreach ($Value in $DataString) {
      # Assume the line contains safe data	
      $safeline = $true
      # Declare variable to count number of increases
      $increase = 0
      # Declare variable to count number of non-inreases (decrease or equal)
      $decrease = 0
      # Split the data line into seperate elements 
      $elements = $Value.split(" ")
      for ($i=0; $i -lt $elements.count-1 ; $i++) {
	    if ( [Math]::Abs($elements[$i]-$elements[$i+1]) -gt 3 )	{ # Change in number can not be more than 3, if it is then data is not safe
	      $safeline = $false	
	    }
	    if ( $elements[$i]-$elements[$i+1] -eq 0 ) { # If numbers are the same the data is not safe
	      $safeline = $false	
	    }
	    if ( [int]$elements[$i] -lt [int]$elements[$i+1] ) { # If number increases
	      $increase=$increase+1
	    } else {                                   # else it decreases (or is the same)
	      $decrease=$decrease+1
	    }
      }
      if ( ($increase -ne 0) -and ($decrease -ne 0) ) { # If there are both increases AND decreases then the data is not safe
	    $safeline = $false
	  }		
	return $safeline
  }
} # End of SafeDataCheck function

# Load the data
$puzzledata = Get-Content C:\jatr\day2.dat

# Declare variables
$safedata = 0

# Go through the data one line at the time
$puzzledata | Foreach {
  
  if (SafeDataCheck $_ -eq $true ) {
	$safedata = $safedata+1
  } else { # if the whole line is not safe let's check if it is safe when each element in the line is removed.
	$safeafterall = 0 # we start off assuming the line is not safe.  
	  $elements = $_.split(" ")
	  
	  for ($i=0; $i -lt $elements.count ; $i++) {
		$tobetested = ""
		$first = 1
		for ($j=0; $j -lt $elements.count ; $j++) {
          if ($j -ne $i ) {
			 if ($first -eq 1) {
			   $tobetested = $tobetested + $elements[$j] 
			   $first = 0
			 } else {
				 $tobetested = $tobetested + " " + $elements[$j]
			 }
		  }
		} 
		# Write-host $tobetested $(safeDataCheck $tobetested)
		if (SafeDataCheck $tobetested -eq $true ) {
		  $safeafterall = 1
		}	
	  }
	 # $safeafterall
	 if ( $safeafterall -eq 1 ) {
            $safedata = $safedata+1
	 }		 
  }
 }
$safedata # 689 (660+)
