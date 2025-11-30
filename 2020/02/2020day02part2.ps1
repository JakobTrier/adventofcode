# By JATR, 2025.09.03
# https://adventofcode.com/2020/day/2#part2

# Load the data
$puzzledata = Get-Content C:\jatr\2020day2.dat

$answer = 0
$puzzledata | Foreach {
	$letter = ($_.split(":").Trim()[0]).split(" ")[1]
	$first  = (($_.split(":").Trim()[0]).split(" ")[0]).split("-")[0] - 1
	$second = (($_.split(":").Trim()[0]).split(" ")[0]).split("-")[1] - 1
	$code   = $_.split(":").Trim()[1]

	if ( ($code[$first] -eq $letter -and $code[$second] -ne $letter) -or ($code[$first] -ne $letter -and $code[$second] -eq $letter)){
		$answer++
	}
}
$answer
