# By JATR, 2025.09.04
# https://adventofcode.com/2018/day/2#part2

# Load the data
$puzzledata = Get-Content 2018day2.dat

for ($i=0 ; $i -lt $puzzledata.length ; $i++ ) {
  for ($j=0 ; $j -lt $puzzledata.length ; $j++ ) {
    if ($i -ne $j) {
      # sammenlign $puzzledata[$i] og $puzzledata[$j]  
      $forskel = 0
	  for ($k=0 ; $k -lt $puzzledata[0].length ; $k++ ) {  
	    if ( $puzzledata[$i][$k] -ne $puzzledata[$j][$k] ) { 
		  $forskel = $forskel + 1
		}
	  }
	  if ( $forskel -eq 1 ) {
		  write-host $puzzledata[$i]
		  write-host $puzzledata[$j]
	  }
    }
  }	
}
