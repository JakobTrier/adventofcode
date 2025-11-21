# By JATR, 2025.11.10
# https://adventofcode.com/2024/day/9

# Load the data
# $puzzledata = "12345"  -> 60
# $puzzledata = "2333133121414131402" -> 1928
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day9.dat # -> 6398608069280

# Declare variables
[collections.arraylist][int[]]$DiskMap = @()
$type           = 1 # 1: A file     -1: Free space
$answer         = 0 # We do not know the answer yet
$id             = 0

# Start by importing the puzzle data into an array and reformat it at the same time
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Reformating and importing data into an array" 
for ($i = 0 ; $i -lt $puzzledata.length ; $i++ ) {
  if ( $type -eq 1 ) { # A file
	for ($j = 0; $j -lt ([string]$puzzledata[$i]) ; $j++ ) {
	  $DiskMap=$DiskMap+$id
	}
	$id++
  } else { # Free space
	for ($j = 0; $j -lt ([string]$puzzledata[$i]) ; $j++ ) {
	  $DiskMap=$DiskMap+(-1)
	}
  }
  $type = $type * (-1)
}
# The above took 12 minutes and 25 seconds to execute.

# Now remove whitespace / freespace..
Write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Defragmenting / removing white space" 
for ($i = 0 ; $i -lt ($diskmap.length).length ; $i++ ) {
  if ($diskmap[$i] -eq -1 ) { # found free space to be filled
    $diskmap[$i] = $diskmap[($diskmap.length).length-1] # copy value at the end of disk to current position
	$diskmap.removeat(($diskmap.length).length-1)       # remove the last element
  }
  for ($j = 0 ; $j -lt 10 ; $j++ ) { # delete freespace at end of array if any.
    if (($diskmap[($diskmap.length).length-1] -eq -1 )) { # white space at the end 
      $diskmap.removeat(($diskmap.length).length-1)       # remove the last element containing white space/free space
    } else {
	  $j=10 # stop searching for whitespace at the end of the array
    }
  }
}

# now calculate checksum
Write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Calculating checksum" 
for ( $i = 0 ; $i -lt $diskmap.length.length ; $i++ ) {
  $answer=$answer + $diskmap[$i]*$i
}
Write-Host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " $answer  # 6398608069280 , found in 1 hour and 4 minutes :-/
