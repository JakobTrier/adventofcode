# By JATR, 2025.09.06
# https://adventofcode.com/2015/day/3

# Load the data
$puzzledata = Get-Content 2015day3.dat

$answer = 0
$LOCATIONS = $null

	$alldata = $alldata + @($_)

  for ($i=0 ; $i -lt $puzzledata.length ; $i++ ) {
    switch ($puzzledata[$i]) {
		"^" {
		  $posy = $posy + 1	
		  $locations = $locations + @($posx,$posy)
		  }
        "V" {
		  $posy = $posy - 1	
		  $locations = $locations + @($posx,$posy)
		  }			  
        "<" {
		  $posx = $posx - 1		
		  $locations = $locations + @($posx,$posy)
		  }
        ">" {
		  $posx = $posx + 1
		  $locations = $locations + @($posx,$posy)
          }			  
	}
  $locationseenbefore = 0
  for ($j=0 ; $j -lt ( ($locations.count -2 ) / 2 ) ; $j++ ){
	  if ( $posx -eq $locations[($j*2)] -and $posy -eq $locations[($j*2 + 1)] ) { $locationseenbefore++ }
  }
  if ( $locationseenbefore -eq 0 ) { $answer++ }
}

Write-host $answer # 2572
