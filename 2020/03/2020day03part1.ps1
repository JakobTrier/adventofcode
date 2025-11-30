# By JATR, 2025.10.31
# https://adventofcode.com/2020/day/3

# Load the data
$puzzledata = Get-Content 2020day3example.dat

# Vi antager at data er et rektangel

$sizex = $puzzledata[0].length
$sizey = $puzzledata.length

$answer = 0
$right = 3
$down  = 1

$location = $right

for ($i = 1 ; $i -lt $sizey ; $i=$i+$down ) { 
  if ( $puzzledata[$i][$location] -eq "#" ) {
	  $answer++
  }
  $location=$location+$right
  if ( $location -ge $sizex ) {
	  $location = $location - $sizex
  }
}
write-host "Answer: " $answer
