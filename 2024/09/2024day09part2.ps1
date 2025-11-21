# By JATR, 2025.11.11
# https://adventofcode.com/2024/day/9#part2

function WriteString
{
	$TheString = ""
	for ($ff = 0 ; $ff -lt $DiskMap.length.length ; $ff++ ) {
		if ( $DiskMap[$ff] -eq -1 ) {
 $TheString = $TheString + "."
		} else {
          $TheString = $TheString + $DiskMap[$ff]
		}			
	}
	write-host $TheString
}
# Load the data
# $puzzledata = "12345"  -> ?
# $puzzledata = "2333133121414131402" # -> 2858
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
 $puzzledata = Get-Content 2024day9.dat # -> 6427437134372

# Declare variables
[collections.arraylist][int[]]$DiskMap = @()
$type           = 1 # 1: A file     -1: Free space
$answer         = 0 # We do not know the answer yet
$id             = 0

# Start by importing the puzzle data into an array
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Reformating and importing data into an array" 
for ($i = 0 ; $i -lt $puzzledata.length ; $i++ ) {
  if ( $type -eq 1 ) { # A file
	for ($j = 0; $j -lt ($puzzledata[$i]-48) ; $j++ ) {
	   $DiskMap=$DiskMap+$id
	}
	$id++
  } else { # Free space
	for ($j = 0; $j -lt ($puzzledata[$i]-48) ; $j++ ) {
	   $DiskMap=$DiskMap+(-1)
	}
  }
	$type = $type * (-1)
}
# The above took 12 minutes and 25 seconds to execute.

# Now remove whitespace / freespace..
Write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Defragmenting"
$highestID = $diskmap[$diskmap.length.length - 1] # should be 9999

for ($i = $diskmap.length.length - 1 ; $i -gt 0 ; $i-- ) { 
  if ($diskmap[$i] -eq $highestID ) { # end of the next file to be processed has been found..
    # determine how long the file is....
	[int]$filelength = $puzzledata[$highestID*2] - 48

	# see if there is a sport where the file can be moved
	for ($j = 0 ; $j -le $i ; $j++ ) {
	  if ($diskmap[$j] -eq -1) { # if an empty spot was found check if there is space enough for the whole file
        $thereisspace = $true
		for ($k = 1 ; $k -lt $filelength ; $k++ ) {
		  if ( $diskmap[$j+$k] -ne -1 ) { $thereisspace = $false }			
		}

      # now we know if there was space or not (stored in $thereisspace )
	  # if there is space enough then move the file
	  if ($thereisspace ) {
        for ($k = 0 ; $k -lt $filelength ; $k++ ) {
		  $diskmap[$i+$k-$filelength+1] = -1          # delete the file
		  $diskmap[$j+$k] = $highestID  # write the file to the new location
	    }
		$j=$i # stop the search for a place to put the file with ID $highestID
	  }
      }
	}
	$highestID-- # check the next ID
 #   $i = $i - $filelength
	
  } # else it must have been an empty slot (-1)
}

# now calculate checksum
Write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Calculating checksum" 
for ( $i = 0 ; $i -lt $diskmap.length.length ; $i++ ) {
 if ($diskmap[$i] -ne -1) { $answer=$answer + $diskmap[$i]*$i }
}
Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " $answer
# $diskmap


