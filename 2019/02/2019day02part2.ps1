# By JATR, 2025.09.04
# https://adventofcode.com/2019/day/2#part2

# Load the data
for ( $verb = 0 ; $verb -le 99 ; $verb++ ) {
	for ( $noun = 0 ; $noun -le 99 ; $noun++ ) {

$puzzledata = Get-Content 2019day2.dat
$elements = $puzzledata.Split(",").Trim()

$elements[1] = $noun
$elements[2] = $verb

$pos = 0
while ( $elements[$pos] -ne 99 ) {
  if ( $elements[$pos] -eq 1 ) {
	  $wheretostoreinput = $elements[($pos+3)]
	  $elements[$wheretostoreinput] = [int]( [int]$elements[[int]$elements[$pos+1]] + [int]$elements[[int]$elements[$pos+2]] )
  }
  if ( $elements[$pos] -eq 2 ) {
	  $wheretostoreinput = $elements[($pos+3)]
	  $elements[$wheretostoreinput] = [int]( [int]$elements[[int]$elements[$pos+1]] * [int]$elements[[int]$elements[$pos+2]] )
  }
  if ( $elements[$pos] -ne 1 -and $elements[$pos] -ne 2 -and $elements[$pos] -ne 99) {
    write-host "ERROR!!!!"
  break
  }
  
  $pos = $pos + 4	
}

if ($elements[0] -eq 19690720) {
  write-host "The answer is 100 *" $noun "+" $verb # 9820
}
	}
}



