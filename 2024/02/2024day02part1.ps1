# By JATR, 2025.01.02
# https://adventofcode.com/2024/day/2#part1
# Load the data
$puzzledata = Get-Content C:\jatr\day2.dat

# Declare variables
$safedata = 0
$safeline = $true

# Go through the data one line at the time
$puzzledata | Foreach {
 # Assume the line contains safe data	
  $safeline = $true
  # Declare variable to count number of increases
  $increase = 0
  # Declare variable to count number of non-inreases (decrease or equal)
  $decrease = 0
  
  # Split the data line into seperate elements 
  $elements = $_.split(" ")
  For ($i=0; $i -lt $elements.count-1 ; $i++) {
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
  if ($safeline -eq $true) {
	  $safedata = $safedata+1
  }
 }
$safedata # 660
