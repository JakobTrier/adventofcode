# By JATR, 2025.12.14
# https://adventofcode.com/2023/day/4

$puzzledata  = Get-Content 2023day04.dat                                     # Load the data, it must be copied from https://adventofcode.com/2023/day/4/input and saved in a file called 2023day04.dat
$answer1     = 0                                                             # Declare variable used to store answer to part 1

$wn=@()  # array for winning numbers
$mn=@()  # array for my numbers

$puzzledata | foreach-object {
  $nf = 0 # numbers found is 0
  $wn= $_.split(":")[1].split("|")[0].trim() -split '\s+'
  $mn= $_.split(":")[1].split("|")[1].trim() -split '\s+'
  for ( $i = 0 ; $i -lt $wn.count ; $i++ ) {
    for ( $j = 0 ; $j -lt $mn.count ; $j++ ) {
	  if ($mn[$j] -eq $wn[$i] ) {$nf++}
	}
  }
  if ( $nf -ne 0 ) { $answer1  = $answer1 + [int][math]::Pow(2, ($nf-1)) }
}
	  
Write-host "Part 1 answer:"$answer1                                         # Write the answer to part 1 to the console
