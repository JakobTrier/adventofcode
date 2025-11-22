# By JATR, 2025.11.22
# https://adventofcode.com/2024/day/25

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day25.dat 

# Declare some variables
$keys = 0
$locks = 0

# Count number of keys and locks

for ( $i = 0 ; $i -lt $puzzledata.length ; $i = $i +8 ) {
  if ( $puzzledata[$i] -eq "....." )	{ # it is a key
	$keys++
  } else { # it is a Lock
    $locks++
  }
}

# Declare more variables
$keydata        = New-Object -TypeName 'Int[,]' -ArgumentList 5,$keys   # Create the matrix for storing key data 
$lockdata       = New-Object -TypeName 'Int[,]' -ArgumentList 5,$keys   # Create the matrix for storing lock data 
$answer         = 0   
$keys           = 0
$locks          = 0

for ( $i = 0 ; $i -lt $puzzledata.length ; $i = $i +8 ) {
  if ( $puzzledata[$i] -eq "....." )	{ # it is a key
	for ( $k = 0 ; $k -lt 5 ; $k++ ) {
	  for ( $j = 1 ; $j -lt 6 ; $j++ ) {
	    if ( $puzzledata[$i+$j][$k] -eq "#" ) { $keydata[$k,$keys]++ }
	  }
	}	
	$keys++
  } else { # it is a Lock
    	for ( $k = 0 ; $k -lt 5 ; $k++ ) {
	  for ( $j = 1 ; $j -lt 6 ; $j++ ) {
	    if ( $puzzledata[$i+$j][$k] -eq "#" ) { $lockdata[$k,$locks]++ }
	  }
	}	
	$locks++
  }
}

# Now check if keys fit in locks

for ( $i = 0 ; $i -lt $keys ; $i++ ) {
	for ( $j = 0 ; $j -lt $locks ; $j++ ) {
	   if ( (($keydata[0,$i]+$lockdata[0,$j]) -lt 6) -and (($keydata[1,$i]+$lockdata[1,$j]) -lt 6) -and (($keydata[2,$i]+$lockdata[2,$j]) -lt 6) -and (($keydata[3,$i]+$lockdata[3,$j]) -lt 6) -and (($keydata[4,$i]+$lockdata[4,$j]) -lt 6)) {
		   $answer++
	   }	
	}
}

Write-host "Answer: " $answer # 3114
