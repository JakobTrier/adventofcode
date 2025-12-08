# By JATR, 2025.12.08
# https://adventofcode.com/2025/day/8
# My most ugly code so far - no time to make it look nicer. It works :)

remove-item ds.dat
remove-item b1.dat
remove-item b2.dat

$puzzledata = Get-Content 2025day08.dat                                     # Load the data, it must be copied from https://adventofcode.com/2025/day/8/input and saved in a file called 2025day08.dat
$answer1    = 0                                                             # Declare variable used to store answer 
$answer2    = 0                                                             # Declare variable used to store answer 

$boxes = $puzzledata.count

$bx = @()
$by = @()
$bz = @()

$ds = @()
$b1 = @()
$b2 = @()

$puzzledata | foreach-object {
  $bx += $_.split(",")[0]
  $by += $_.split(",")[1]
  $bz += $_.split(",")[2]
}

function DistanceSquared ($x1,$y1,$z1,$x2,$y2,$z2) { # No need to calculate the actual distance, the squared distance will work and is cheaper to calcuate CPU wise
  return ($x1-$x2)*($x1-$x2) + ($y1-$y2)*($y1-$y2) + ($z1-$z2)*($z1-$z2)
}
	
for ($i = 0 ; $i -lt $boxes ; $i++) {   # this took forever and consummed a lot of memory so wrote the result to file 1000 times and loaded it all in the end to speed up things... Probably could be done in a nicer way...
  for ($j = ($i + 1) ; $j -lt $boxes ; $j++) {   
    $ds += DistanceSquared $bx[$i] $by[$i] $bz[$i] $bx[$j] $by[$j] $bz[$j]
    $b1 += $j
    $b2 += $i
  }
  $ds | out-file ds.dat -append	
  $b1 | out-file b1.dat -append
  $b2 | out-file b2.dat -append
  $ds = @()
  $b1 = @()
  $b2 = @()
}
$ds = Get-Content ds.dat
$b1 = Get-Content b1.dat
$b2 = Get-Content b2.dat

$i=0                                    # Thanks to Lasse for the next 8 lines allowing me to easily do the sorting I wanted.
$list = foreach ($element in $ds) {
  [PSCustomObject]@{
    ds = [int64]$ds[$i]
    b1 = [int]$b1[$i]
    b2 = [int]$b2[$i]
  }
  $i++
}
$list = ($list | sort ds) # Now I can sort all the distances between junction boxes so that I can get to work on the 1000 shortest ones....

$c=@(@())   # circuits - an array of arrays is used for the circuits
for  ($f =0 ; $f -lt  $boxes; $f++ ){ 
  $c += ,@($f) # populate all the circuits with 1 junction box each...
}

$list[0..999] | foreach-object {   
  for ($i = 0 ; $i -lt $boxes ; $i++ ) {	     # find circuits where the two junction boxes are currently located.
    if ( $c[$i] -contains $_.b1 ) { $b1c = $i }  # junction box 1 found, store its location
    if ( $c[$i] -contains $_.b2 ) { $b2c = $i }  # junction box 2 found, store its location
  }	
  if ( $b1c -ne $b2c ) { # if the two junction boxes to connect are NOT in the same circuit then join the circuits.
    $c[$b1c] += $c[$b2c]   # add circuit 2 to circuit one
    $c[$b2c] = @()         # empty the old circuit 2
  }
}

$list = foreach ($element in $c) {  # This is just a silly way to allow me to sort the length of all the circuits.
 [PSCustomObject]@{
	cl = $element.length  # cl short for circuit length
 }
}
$list = ($list | sort cl -Descending) # Now I can sort the lengths of all the circuits
$answer1 =  $list[0].cl * $list[1].cl * $list[2].cl   # Multiply the length of the 3 longest circuits to get the answer to part 1 (54600 in my case)

Write-host "Part 1 answer:"$answer1                                         # Write the answer to part 1 to the console


