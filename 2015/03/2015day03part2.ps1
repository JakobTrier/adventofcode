# By JATR, 2025.09.06
# https://adventofcode.com/2015/day/3#part2

# Load the data
$puzzledata = Get-Content 2015day3.dat

$posxrobot = 0
$posyrobot = 0
$posx = 0
$posy = 0

$answer = 0
$LOCATIONS = $null

	$alldata = $alldata + @($_)

  for ($i=0 ; $i -lt $puzzledata.length ; $i++ ) {
    switch ($puzzledata[$i]) {
		"^" {
		  if ( $i % 2 -eq 0 ) {
			   $posy = $posy + 1	
			   $locations = $locations + @($posx,$posy)
		  } else {
		     $posyrobot = $posyrobot + 1	
			 $locations = $locations + @($posxrobot,$posyrobot)
		     }
		   }
        "V" {
			if ( $i % 2 -eq 0 ) {
		  $posy = $posy - 1	
		  $locations = $locations + @($posx,$posy)
		  		  } else {
		     $posyrobot = $posyrobot - 1	
			 $locations = $locations + @($posxrobot,$posyrobot)
		  }	
		}		  
        "<" {
			if ( $i % 2 -eq 0 ) {
		  $posx = $posx - 1		
		  $locations = $locations + @($posx,$posy)
		  		  } else {
		     $posxrobot = $posxrobot - 1	
			 $locations = $locations + @($posxrobot,$posyrobot)
		  }
		}
        ">" {
			if ( $i % 2 -eq 0 ) {
		  $posx = $posx + 1
		  $locations = $locations + @($posx,$posy)
		  		  } else {
		     $posxrobot = $posxrobot + 1	
			 $locations = $locations + @($posxrobot,$posyrobot)
          }		
		}		  
	}
  $locationseenbefore = 0
  for ($j=0 ; $j -lt ( ($locations.count -2 ) / 2 ) ; $j++ ){
if ( $i % 2 -eq 0 ) {	 
	 if ( $posx -eq $locations[($j*2)] -and $posy -eq $locations[($j*2 + 1)] ) { $locationseenbefore++ }
} else { 
	 	 if ( $posxrobot -eq $locations[($j*2)] -and $posyrobot -eq $locations[($j*2 + 1)] ) { $locationseenbefore++ }
}
  }
  if ( $locationseenbefore -eq 0 ) { $answer++ }
}

Write-host $answer #  2631
