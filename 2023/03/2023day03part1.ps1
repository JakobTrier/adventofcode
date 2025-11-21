# By JATR, 2025.11.06
# https://adventofcode.com/2023/day/3

# Load the data
$puzzledata = Get-Content 2023day3.dat

$answer = 0

$sizex=$puzzledata[0].length
$sizey=$puzzledata.length

for ($lines = 0 ; $lines -lt $sizey ; $lines++) { 
  
 for ($pos = 0 ; $pos -lt $sizex ; $pos++) { 
  if ($puzzledata[$lines][$pos] -Match '[0-9]' ) {
     if ($puzzledata[$lines][$pos+1] -NotMatch '[0-9]') {
		 $number=[int]$puzzledata[$lines][$pos]-48 # 1 digit number found
		 # check if it should be added..
		 $addme = $false
		 for ($j = -1 ; $j -le 1 ; $j++ ) {
		  for ($i = -1 ; $i -le 1 ; $i++ ) {	 
			 if ( [int]$pos+$i -lt $sizex -and [int]$pos+$i -ge 0 -and [int]$lines+$j -lt $sizey -and [int]$lines+$j -ge 0 ) {
				 #we are withing the frame...
				 if ( $puzzledata[$lines+$j][$pos+$i] -NotMatch '[0123456789]' -and $puzzledata[$lines+$j][$pos+$i] -ne '.') { $addme = $true }
			 }
		   }
		 }	
        if ( $addme ) { $answer += $number }		 
	 } elseif ($puzzledata[$lines][$pos+2] -NotMatch '[0-9]') {
		 $number=([int]$puzzledata[$lines][$pos]-48)*10 + [int]$puzzledata[$lines][$pos+1] - 48 # 2 digit number found
		 $pos++
		 # check if it should be added..
		 $addme = $false
		 for ($j = -1 ; $j -le 1 ; $j++ ) {
		  for ($i = -2 ; $i -le 1 ; $i++ ) {	 
			 if ( [int]$pos+$i -lt $sizex -and [int]$pos+$i -ge 0 -and [int]$lines+$j -lt $sizey -and [int]$lines+$j -ge 0 ) {
				 #we are withing the frame...
				 if ( $puzzledata[$lines+$j][$pos+$i] -NotMatch '[0123456789]' -and $puzzledata[$lines+$j][$pos+$i] -ne '.') { $addme = $true }
			 }
		   }
		 }		 
		 if ( $addme ) { $answer += $number }
	 } else {
	     $number=([int]$puzzledata[$lines][$pos]-48)*100 + ([int]$puzzledata[$lines][$pos+1]-48)*10 + [int]$puzzledata[$lines][$pos+2]-48 # 3 digit number found
		 $pos++
		 $pos++
		 		 # check if it should be added..
		 $addme = $false
		 for ($j = -1 ; $j -le 1 ; $j++ ) {
		  for ($i = -3 ; $i -le 1 ; $i++ ) {	 
			 if ( [int]$pos+$i -lt $sizex -and [int]$pos+$i -ge 0 -and [int]$lines+$j -lt $sizey -and [int]$lines+$j -ge 0 ) {
				 #we are withing the frame...
				  
				 if ( $puzzledata[$lines+$j][$pos+$i] -NotMatch '[0123456789]' -and $puzzledata[$lines+$j][$pos+$i] -ne '.') { 
				    $addme = $true 
				}
				# write-host Frame $([int]$pos+$i) $([int]$lines+$j) $puzzledata[$lines+$j][$pos+$i] $addme
			 }
		   }
		 }
		 if ( $addme ) { $answer += $number }
	 }
	#  write-host $number 
	} 
 }
}
write-host "Part 1 answer: " $answer 




