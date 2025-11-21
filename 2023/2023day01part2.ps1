# By JATR, 2025.08.19
# https://adventofcode.com/2023/day/1


# Load the data
$puzzledata = Get-Content C:\jatr\2023day1.dat

$answer = 0

# Go through the data one line at the time
$puzzledata | Foreach {
	$linedata = $_
	$nodatafound = 1
	for ($i=0;$i -lt $linedata.Length;$i++) {
	   
	   if ( $linedata[$i] -match "^\d+$") { # if it is a number 
	     if ( $nodatafound -eq 1 ) { # first time we find a number in this linedata
			 $nodatafound = 0 # we have now found a number
			 $firstnumber = $linedata[$i]
	
		 }
		 $lastnumber = $linedata[$i]
	}
   }
   $answer = $answer + [int][string]$firstnumber * 10 + [int][string]$lastnumber 
}
$answer

