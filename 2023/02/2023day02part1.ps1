# By JATR, 2025.08.29
# https://adventofcode.com/2023/day/2

# Load the data
$puzzledata = Get-Content C:\jatr\2023day2.dat
$answer = 0

$puzzledata | Foreach {
    $possiblegame = 1
	$gamenumber = [string](($_).split(":")[0].substring(5,(($_).split(":")[0]).length - 5))
	write-host "Game number:"$gamenumber
	
	$colourdata = @((($_).split(":"))[1].split(";"))
	
	for ($i=0 ;$i -lt ($colourdata.length); $i++) {
	  $sets = $colourdata[$i].split(",")
	  for ($j=0 ;$j -lt ($sets.length); $j++) {
	    switch ($sets[$j].split(" ")[2]) {
		  red   { if ( [int]$sets[$j].split(" ")[1] -gt 12 ){ $possiblegame = 0 } }	
		  green { if ( [int]$sets[$j].split(" ")[1] -gt 13 ){ $possiblegame = 0 } }	
		  blue  { if ( [int]$sets[$j].split(" ")[1] -gt 14 ){ $possiblegame = 0 } }	
		}
	  }
	  write-host $colourdata[$i] $possiblegame
	}
	if ($possiblegame -eq 1) {
		Write-host $gamenumber " is ok"
       $answer = $answer + $gamenumber
	}
}
Write-host "The answer is"$answer
