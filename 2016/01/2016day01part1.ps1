# By JATR, 2025.08.20
# https://adventofcode.com/2016/day/1

# Load the data
$puzzledata = Get-Content 2016day1.dat

$data = (($puzzledata.replace(' ' , '')) -split ",")

# Start position
$x=0
$y=0
$d='N'

$data | Foreach {
  $linedata = $_ 
  
  switch ($d) {
  N  {
     if ( $linedata.Substring(0,1) -eq 'R' ) {
		 $x = $x + [int]$linedata.Substring(1)
		 $d = 'E'
	 } else { # 'L'
	 	 $x = $x - [int]$linedata.Substring(1)
		 $d = 'W'
	 }
  }
  S {
     if ( $linedata.Substring(0,1) -eq 'R' ) {
		 $x = $x - [int]$linedata.Substring(1)
		 $d = 'W'
	 } else { # 'L'
	 	 $x = $x + [int]$linedata.Substring(1)
		 $d = 'E'
	 }
  }  
  
  E {
     if ( $linedata.Substring(0,1) -eq 'R' ) {
		 $y = $y - [int]$linedata.Substring(1)
		 $d = 'S'
	 } else { # 'L'
	 	 $y = $y + [int]$linedata.Substring(1)
		 $d = 'N'
	 }
  }  
  
  W {
     if ( $linedata.Substring(0,1) -eq 'R' ) {
		 $y = $y + [int]$linedata.Substring(1)
		 $d = 'N'
	 } else { # 'L'
	 	 $y = $y - [int]$linedata.Substring(1)
		 $d = 'S'
	 }
  }  
  }
 # Write-Host $linedata " --> x:" $x " y:" $y " d:" $d
}

$answer = [Math]::Abs($x)+[Math]::Abs($y)
Write-Host $answer
