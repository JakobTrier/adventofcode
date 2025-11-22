# By JATR, 2025.09.04
# https://adventofcode.com/2016/day/3#part2

# Load the data
$puzzledata = Get-Content 2016day3.dat

$answer = 0

for ($i = 0 ; $i -lt $puzzledata.count ; $i = $i + 3 ) {
 $number1 = ($puzzledata[$i] -replace '\s+', ' ').trim().split(" ")
 $number2 = ($puzzledata[$i+1] -replace '\s+', ' ').trim().split(" ")
 $number3 = ($puzzledata[$i+2] -replace '\s+', ' ').trim().split(" ")

$n0 = [int]$number1[0]
$n1 = [int]$number2[0]
$n2 = [int]$number3[0]

if ($n0 -ge $n1 -and $n0 -ge $n2) {
  $max = $n0
  if ($n1 -ge $n2) {
	$mid = $n1
    $min = $n2  
  } else {
	$mid = $n2
    $min = $n1  
  }
}
if ($n1 -ge $n0 -and $n1 -ge $n2) {
  $max = $n1
  if ($n0 -ge $n2) {
	$mid = $n0
    $min = $n2  
  } else {
	$mid = $n2
    $min = $n0  
  }
}
if ($n2 -ge $n1 -and $n2 -ge $n0) {
  $max = $n2
  if ($n1 -ge $n0) {
	$mid = $n1
    $min = $n0
  } else {
	$mid = $n0
    $min = $n1  
  }
}

 if ( $max -lt ($min + $mid)  ) { 
   $answer++ 
 }
 
 
 $n0 = [int]$number1[1]
$n1 = [int]$number2[1]
$n2 = [int]$number3[1]

if ($n0 -ge $n1 -and $n0 -ge $n2) {
  $max = $n0
  if ($n1 -ge $n2) {
	$mid = $n1
    $min = $n2  
  } else {
	$mid = $n2
    $min = $n1  
  }
}
if ($n1 -ge $n0 -and $n1 -ge $n2) {
  $max = $n1
  if ($n0 -ge $n2) {
	$mid = $n0
    $min = $n2  
  } else {
	$mid = $n2
    $min = $n0  
  }
}
if ($n2 -ge $n1 -and $n2 -ge $n0) {
  $max = $n2
  if ($n1 -ge $n0) {
	$mid = $n1
    $min = $n0
  } else {
	$mid = $n0
    $min = $n1  
  }
}

 if ( $max -lt ($min + $mid)  ) { 
   $answer++ 
 }
 
 $n0 = [int]$number1[2]
$n1 = [int]$number2[2]
$n2 = [int]$number3[2]

if ($n0 -ge $n1 -and $n0 -ge $n2) {
  $max = $n0
  if ($n1 -ge $n2) {
	$mid = $n1
    $min = $n2  
  } else {
	$mid = $n2
    $min = $n1  
  }
}
if ($n1 -ge $n0 -and $n1 -ge $n2) {
  $max = $n1
  if ($n0 -ge $n2) {
	$mid = $n0
    $min = $n2  
  } else {
	$mid = $n2
    $min = $n0  
  }
}
if ($n2 -ge $n1 -and $n2 -ge $n0) {
  $max = $n2
  if ($n1 -ge $n0) {
	$mid = $n1
    $min = $n0
  } else {
	$mid = $n0
    $min = $n1  
  }
}

 if ( $max -lt ($min + $mid)  ) { 
   $answer++ 
 } 
}
$answer

Write-host "The answer is"$answer   # 1921
