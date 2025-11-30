# By JATR, 2025.09.03
# https://adventofcode.com/2020/day/2

# Load the data
$puzzledata = Get-Content 2020day2.dat

$answer = 0
$line=0
$puzzledata | Foreach {
	$letter = ($_.split(":").Trim()[0]).split(" ")[1]
	$min    = (($_.split(":").Trim()[0]).split(" ")[0]).split("-")[0]
	$max    = (($_.split(":").Trim()[0]).split(" ")[0]).split("-")[1]
	$code   = $_.split(":").Trim()[1]
	
	$number = ([regex]::Matches($code, $letter )).count 
}
$answer
