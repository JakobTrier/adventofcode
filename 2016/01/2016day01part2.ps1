# By JATR, 2025.08.21
# https://adventofcode.com/2016/day/1

# Load the data
$puzzledata = Get-Content 2016day1.dat

$data = (($puzzledata.replace(' ' , '')) -split ",")

# Start position
$x=0
$y=0
$d='N'
$mypath = @($x,$y)
		
$data | Foreach {
   $linedata = $_

   switch ($d) {
   N  {
      if ( $linedata.Substring(0,1) -eq 'R' ) {
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
    $walked = @(($x + $i),$y)
            $mypath = $mypath  + $walked
          }
  $x = $x + [int]$linedata.Substring(1)
  $d = 'E'
  } else { # 'L'
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
    $walked = @(($x - $i),$y)
            $mypath = $mypath  + $walked
          }
   $x = $x - [int]$linedata.Substring(1)
  $d = 'W'
  }

   }
   S {
      if ( $linedata.Substring(0,1) -eq 'R' ) {
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
    $walked = @(($x - $i),$y)
            $mypath = $mypath  + $walked
          }
  $x = $x - [int]$linedata.Substring(1)
  $d = 'W'
  } else { # 'L'
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
    $walked = @(($x + $i),$y)
            $mypath = $mypath  + $walked
          }
   $x = $x + [int]$linedata.Substring(1)
  $d = 'E'
  }
   }

   E {
      if ( $linedata.Substring(0,1) -eq 'R' ) {
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
  $walked = @($x,($y - $i))
          $mypath = $mypath  + $walked
          }

  $y = $y - [int]$linedata.Substring(1)
  $d = 'S'
  } else { # 'L'
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
  $walked = @($x,($y + $i))
          $mypath = $mypath  + $walked
          }

   $y = $y + [int]$linedata.Substring(1)
  $d = 'N'
  }
   }

   W {
      if ( $linedata.Substring(0,1) -eq 'R' ) {
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
  $walked = @($x,($y + $i))
          $mypath = $mypath  + $walked
          }

  $y = $y + [int]$linedata.Substring(1)
  $d = 'N'
  } else { # 'L'
  for ($i=1; $i -lt ([int]$linedata.Substring(1)+1) ; $i++) {
  $walked = @($x,($y - $i))
          $mypath = $mypath  + $walked
          }

   $y = $y - [int]$linedata.Substring(1)
  $d = 'S'
  }
   }
   }
   Write-Host $linedata " --> x:" $x " y:" $y " d:" $d
 }
 
 $steps = $mypath.count /2
 
 for ($j=0; $j -lt $steps ; $j++) {
 for ($i=0; $i -lt $steps ; $i++) {
   if ($mypath[$i*2] -eq $mypath[$j*2] -and $mypath[$i*2+1] -eq $mypath[$j*2+1] -and $i -ne $j) {

   Write-Host "Bingo x:" $mypath[$i*2] " y:" $mypath[$i*2+1]
  $answer = [Math]::Abs($mypath[$i*2])+[Math]::Abs($mypath[$i*2+1])
 Write-Host $answer
 $i = $steps
 $j = $steps
   }
 }
 }
