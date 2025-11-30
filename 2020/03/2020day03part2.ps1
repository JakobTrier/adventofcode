# By JATR, 2025.10.31
# https://adventofcode.com/2020/day/3#part2

# Load the data
$puzzledata = Get-Content 2020day3.dat

# Vi antager at data er et rektangel

$sizex = $puzzledata[0].length
$sizey = $puzzledata.length

function Slope([int]$right,[int]$down) {
	$location = $right
    $answer = 0
    for ($i = 1 ; $i -lt $sizey ; $i=$i+$down ) { 
      if ( $puzzledata[$i][$location] -eq "#" ) {
	    $answer++
      }
      $location=$location+$right
      if ( $location -ge $sizex ) {
	    $location = $location - $sizex
      }
    }
  return $answer
}

Write-host (Slope 1 1)*(Slope 3 1)*(Slope 5 1)*(Slope 7 1)*(Slope 1 2)
Write-host $($(Slope 1 1)*$(Slope 3 1)*$(Slope 5 1)*$(Slope 7 1)*$(Slope 1 2))
