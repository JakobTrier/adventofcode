# By JATR, 2025.12.15
# https://adventofcode.com/2023/day/4#part2

$puzzledata  = Get-Content 2023day04.dat                                     # Load the data, it must be copied from https://adventofcode.com/2023/day/4/input and saved in a file called 2023day04.dat
$answer2    = 0                                                             # Declare variable used to store answer to part 1

$wn=@()  # array for winning numbers
$mn=@()  # array for my numbers
$card=@() # array to keep track of how many of each card you have

for ($f=0;$f -lt $puzzledata.length;$f++)
{ $card += 1 }

$currentcard = 0 # Variable to keep track of what card number is being processed
$puzzledata | foreach-object {
  $nf = 0 # numbers found is 0
  $wn= $_.split(":")[1].split("|")[0].trim() -split '\s+'
  $mn= $_.split(":")[1].split("|")[1].trim() -split '\s+'
  for ( $i = 0 ; $i -lt $wn.count ; $i++ ) {
    for ( $j = 0 ; $j -lt $mn.count ; $j++ ) {
	  if ($mn[$j] -eq $wn[$i] ) {$nf++}
	}
  }
  if ( $nf -ne 0 ) { 
    for ( $i = 1 ; $i -le $nf ; $i++ ) {
	  $card[$($currentcard+$i)] += $card[$currentcard] 
	}
  }
  $currentcard++
}

$answer2 = ($card | measure-object -sum).sum

Write-host "Part 2 answer:"$answer2                                         # Write the answer to part 2 to the console 6050769
