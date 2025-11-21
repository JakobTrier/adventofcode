# By JATR, 2025.11.07
# https://adventofcode.com/2024/day/8

function AddAntinodes([int]$x1,[int]$y1,[int]$x2,[int]$y2) {
	$dx = $x1-$x2
	$dy = $y1-$y2
	
	# first one
	$xa = $x1 + $dx
	$ya = $y1 + $dy
	
	if ($xa -ge 0 -and $ya -ge 0 -and $xa -lt $sizex -and $ya -lt $sizey) { # antinode is inside the frame
	  write-host "Antinode 1: (" $xa "," $ya ")"
	  $antinodes[$xa,$ya] = "X"
	} else {
	  write-host "Antinode 1: (n/a)"
    }
	
	#second one
	$xa = $x2 - $dx
	$ya = $y2 - $dy
	
	if ($xa -ge 0 -and $ya -ge 0 -and $xa -lt $sizex -and $ya -lt $sizey) { # antinode is inside the frame
	  write-host "Antinode 2: (" $xa "," $ya ")"
	  $antinodes[$xa,$ya] = "X"
	} else {
	  write-host "Antinode 2: (n/a)"
    }
	
}
	


# Load the data
$puzzledata = Get-Content 2024day8.dat


$sizex = $puzzledata[0].length
$sizey = $puzzledata.length

# Create the matrix for storing puzzledata 
$Map = New-Object -TypeName 'Char[,]' -ArgumentList $sizex,$sizey

# Create the matrix for storing antinodes information 
$antinodes = New-Object -TypeName 'Char[,]' -ArgumentList $sizex,$sizey

#used to store antennas...
$antennas = New-Object -TypeName 'Int[,]' -ArgumentList 4,2

# Lets populate the matrix with data...
for ($i = 0 ; $i -lt $sizex ; $i++) { 
  for ($j = 0 ; $j -lt $sizey ; $j++ ) {
  $Map[$i,$j] = $puzzledata[$j][$i]
  }
}
# Now data is easily accessable...



# Count number of antennas
$checked = "" # we have not checked any antenna type yet....

for ($i = 0 ; $i -lt $sizex ; $i++) { 
  for ($j = 0 ; $j -lt $sizey ; $j++ ) {
  if ( $Map[$i,$j] -ne '.' ) {
    
	if ( $checked -cNotMatch $Map[$i,$j] ) { # if we have not seen this type of antenna yet then lets examine it....
	  $checked=$checked + $Map[$i,$j]
	  # Let us locate all the similar antennas
	  $numberofantennas=0
	  for ($ii = 0 ; $ii -lt $sizex ; $ii++) { 
         for ($jj = 0 ; $jj -lt $sizey ; $jj++ ) {
	        if ( $Map[$i,$j] -ceq $Map[$ii,$jj] ) { # use ceq and not eq as it must be a case sensitive compare
				
				$antennas[$numberofantennas,0] = $ii   # X
				$antennas[$numberofantennas,1] = $jj   # Y
				
				$numberofantennas++
				
			}
		 }
	  }
	  Write-host "-------(" $numberofantennas ")---------"
	  for ($n = 0 ; $n -lt $numberofantennas ; $n++ ) {
	    Write-host "(" $antennas[$n,0] "," $antennas[$n,1] ")"
	  }
	  AddAntinodes $antennas[0,0] $antennas[0,1] $antennas[1,0] $antennas[1,1]
	  AddAntinodes $antennas[0,0] $antennas[0,1] $antennas[2,0] $antennas[2,1]
	  AddAntinodes $antennas[1,0] $antennas[1,1] $antennas[2,0] $antennas[2,1]
	  if ( $numberofantennas -eq 4 ) {
		AddAntinodes $antennas[0,0] $antennas[0,1] $antennas[3,0] $antennas[3,1]
	    AddAntinodes $antennas[1,0] $antennas[1,1] $antennas[3,0] $antennas[3,1]
	    AddAntinodes $antennas[2,0] $antennas[2,1] $antennas[3,0] $antennas[3,1]
		  
	  }
	}
  }
  }
}
Write-host "Number of antennas types: " $checked.length
Write-host "Antennas types: " $checked

# count number of antinodes
$answer = 0
for ($i = 0 ; $i -lt $sizex ; $i++) { 
  for ($j = 0 ; $j -lt $sizey ; $j++ ) {
  if ( $antinodes[$i,$j] -eq 'X' ) {
	   $answer++
    }
  }
}
  
  Write-Host "Answer: " $answer
