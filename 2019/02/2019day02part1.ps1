# By JATR, 2025.09.04
# https://adventofcode.com/2019/day/2

# Load the data
$puzzledata = Get-Content 2019day2.dat

$elements = $puzzledata.Split(",").Trim()
$elements[1] = '12'
$elements[2] = '2'

$pos = 0

while ( $elements[$pos] -ne 99 ) {
  if ( $elements[$pos] -eq 1 ) {
	  write-host $pos "Addition" $elements[($elements[$pos+1])] + $elements[($elements[$pos+2])] "at" $elements[($pos+3)]
	  $wheretostoreinput = $elements[($pos+3)]
	  $elements[$wheretostoreinput] = [int]( [int]$elements[[int]$elements[$pos+1]] + [int]$elements[[int]$elements[$pos+2]] )
  }
  if ( $elements[$pos] -eq 2 ) {
	  write-host $pos "Addition" $elements[($elements[$pos+1])] * $elements[($elements[$pos+2])] "at" $elements[($pos+3)]
	  $wheretostoreinput = $elements[($pos+3)]
	  $elements[$wheretostoreinput] = [int]( [int]$elements[[int]$elements[$pos+1]] * [int]$elements[[int]$elements[$pos+2]] )
  }
  $pos = $pos + 4	
}

write-host "The answer is" $elements[0] " The position is" $pos
