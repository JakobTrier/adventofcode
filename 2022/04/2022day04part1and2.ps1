# By JATR, 2025.12.15
# https://adventofcode.com/2022/day/4

$puzzledata  = Get-Content 2022day04.dat                                     # Load the data, it must be copied from https://adventofcode.com/2022/day/4/input and saved in a file called 2022day04.dat
$answer1     = 0                                                             # Declare variable used to store answer to part 1
$answer2     = 0                                                             # Declare variable used to store answer to part 1


$puzzledata | foreach-object {
  $a1 = [int]($_.split(",")[0].split("-")[0])
  $a2 = [int]($_.split(",")[0].split("-")[1])
  $b1 = [int]($_.split(",")[1].split("-")[0])
  $b2 = [int]($_.split(",")[1].split("-")[1])
  
  if (($b1 -ge $a1 -and $b2 -le $a2) -or ($a1 -ge $b1 -and $a2 -le $b2)) {
	  $answer1++
  }	  
  if (-not (($b1 -gt $a2) -or ($a1 -gt $b2))) {
	  $answer2++
  }	  
}
	  
Write-host "Part 1 answer:"$answer1                                         # Write the answer to part 1 to the console
Write-host "Part 2 answer:"$answer2                                         # Write the answer to part 2 to the console
