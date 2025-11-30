# set-ExecutionPolicy -ExecutionPolicy Unrestricted
# By JATR, 2025.11.05
# https://adventofcode.com/2021/day/3


# Load the data
$puzzledata = Get-Content 2021day3.dat

# build a string with length equal to number of lines in puzzle data to keep track of what lines are to be used.


# -- oxygen generator rating ---

$tracker = @()
for ($i = 1 ; $i -le $puzzledata.count ; $i++) { 
 $tracker = $tracker + "1"
}

$bit = 0

$howmanyones = $puzzledata.count

while ( $howmanyones -gt 1 ) {
$zeros = 0
$ones  = 0

for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
 if ($tracker[$i] -eq "1") {
  if  ( $puzzledata[$i][$bit] -eq "0" ) {
	  $zeros++
  } else {
	  $ones++
  }
 }
}

if ( $ones -ge $zeros ) {
	$mostof = "1"
   } else { 
    $mostof = "0"
  }

for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
  if  ( $puzzledata[$i][$bit] -ne $mostof ) {
	  $tracker[$i] = "0"
  } 
}

$howmanyones = 0

for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
  if  ( $tracker[$i] -eq "1" ) {
	  $howmanyones++
  } 

}

 write-host "1's: " $howmanyones " Bit: " $bit
 write-host $tracker
 $bit++
}

# Tell me the number ( 011000111111b = 1599 )
for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
 if ($tracker[$i] -eq "1") {
	 write-host $puzzledata[$i]
	 break
 }
}

# --- CO2 scrubber rating

$tracker = @()
for ($i = 1 ; $i -le $puzzledata.count ; $i++) { 
 $tracker = $tracker + "1"
}

$bit = 0

$howmanyones = $puzzledata.count

while ( $howmanyones -gt 1 ) {
$zeros = 0
$ones  = 0

for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
 if ($tracker[$i] -eq "1") {
  if  ( $puzzledata[$i][$bit] -eq "0" ) {
	  $zeros++
  } else {
	  $ones++
  }
 }
}

if ( $ones -lt $zeros ) {
	$mostof = "1"
   } else { 
    $mostof = "0"
  }

for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
  if  ( $puzzledata[$i][$bit] -ne $mostof ) {
	  $tracker[$i] = "0"
  } 
}

$howmanyones = 0

for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
  if  ( $tracker[$i] -eq "1" ) {
	  $howmanyones++
  } 

}

 write-host "1's: " $howmanyones " Bit: " $bit
 write-host $tracker
 $bit++
}

# Tell me the number ( 101011000100b = 2756  )
for ($i = 0 ; $i -lt $puzzledata.count ; $i++) { 
 if ($tracker[$i] -eq "1") {
	 write-host $puzzledata[$i]
	 break
 }
}


# 1599 * 2756 = 4406844
