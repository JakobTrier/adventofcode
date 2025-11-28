# By JATR, 2025.11.24
# https://adventofcode.com/2024/day/18

function PrintMap
{
    for ($ky = 0; $ky -lt $sizey ; $ky++){
      $line = $null	
      for ($kx = 0; $kx -lt $sizex ; $kx++){
	    $line = $line + [string]$Map[$kx,$ky]
      }
      Write-host $line
	}
}

# Load the data
$puzzledata = Get-Content 2024day15.dat

$sizex = $puzzledata[0].length

# let us see how many lines there are in the matrix....
$i = 1
while ( $puzzledata[$i] -ne $puzzledata[0] ) {
	if ( $puzzledata[$i].indexof("@") -ne -1 ) { # we found the robot
	  $robotx = $puzzledata[$i].indexof("@")
	  $roboty = $i
	}
	$i++
}
$sizey = $i + 1

# Create the matrix for storing puzzledata 
$Map = New-Object -TypeName 'Char[,]' -ArgumentList $sizex,$sizey

write-host $sizex $sizey 
# Load the data into the $Map array
for ( $i = 0 ; $i -lt $sizex ; $i++) {
	for ( $j = 0 ; $j -lt $sizey ; $j++ ) {
	  $Map[$i,$j] = $puzzledata[$j][$i]
    }
  }

# load orders into a string

$orders=""
$i = 0
$puzzledata | foreach {
  if ($i -gt $sizey) { # if we reached the part of the data containing move instructions for the robot
	$orders=$orders+[string]$puzzledata[$i]
  }	
  $i++	
}

PrintMap
write-host "The robot is at (" $robotx "," $roboty "). " $orders.length " orders waiting to be executed"

for ( $f = 0 ; $f -lt $orders.length ; $f++ ) { # handle all the orders one by one
  switch ( $orders[$f] ) {
   "^" { $dx =  0 ; $dy = -1 } # Up
   "v" { $dx =  0 ; $dy =  1 } # Down
   "<" { $dx = -1 ; $dy =  0 } # Left
   ">" { $dx =  1 ; $dy =  0 } # Right
  }
  write-host "Current order (" $($f + 1) "): " $orders[$f]
  if ( -not ($Map[$($robotx + $dx),$($roboty + $dy)] -eq '#')  ) { #if the robot is not trying to go into a wall then...
   if ($Map[$($robotx + $dx),$($roboty + $dy)] -eq "." ) { # there is space for the robot to move...
      Write-host "Moving from (" $robotx "," $roboty ") to (" $($robotx + $dx) "," $($roboty + $dy) ")"
	  $Map[$($robotx + $dx),$($roboty + $dy)] = "@"
	  $Map[$robotx,$roboty] = "."
	  $robotx = $robotx + $dx
	  $roboty = $roboty + $dy
   } else { # there is a box where the robot wants to move.....
     Write-host "Box in the way" # check if we can push it first...
	 $spacefound = $false
	 if ($dy -eq 0) { # it is a horizontal move
	   if ( $dx -gt 0 ) { # it is a move to the Right
		 for ( $m = $robotx ; $m -lt $sizex ; $m++ ) {
			if ( $Map[$m,$roboty] -eq '.' -or $Map[$m,$roboty] -eq '#' ) { # either there is space or we hit a wall
			   if ( $Map[$m,$roboty] -eq '.' ) {
				     $spacefound = $true 
				     $space = $m
			       } 
				   $m = $sizex
			   } 
		 }
	   } else { # it is a move to the Left
	     for ( $m = 1 ; $m -lt $robotx ; $m++ ) {
			if ( $Map[$($robotx - $m),$roboty] -eq '.' -or $Map[$($robotx - $m),$roboty] -eq '#') { # either there is space or we hit a wall
			  if ( $Map[$($robotx - $m),$roboty] -eq '.' ) { 
			      $spacefound = $true 
				  $space = $($robotx - $m) 
			  }
			  $m = $robotx
			} 
		 }
	   }	 
	 } else { # it is a vertical move
	 	   if ( $dy -gt 0 ) { # it is a move downwards
		 for ( $m = $roboty ; $m -lt $sizey ; $m++ ) {
			if ( $Map[$robotx,$m] -eq '.' -or $Map[$robotx,$m] -eq '#' ) { # either there is space or we hit a wall
			  if ( $Map[$robotx,$m] -eq '.' ) {
				  $spacefound = $true 
				  $space = $m 
			  }
			  $m = $sizey
			} 
		 }
	   } else { # it is a move upwards
	     for ( $m = 1 ; $m -lt $roboty ; $m++ ) {
			if ( $Map[$robotx,$($roboty - $m)] -eq '.' -or $Map[$robotx,$($roboty - $m)] -eq '#') { # either there is space or we hit a wall
			   if ( $Map[$robotx,$($roboty - $m)] -eq '.' ) { 
			   $spacefound = $true 
 			   $space = $($roboty - $m)
			   }
			    $m = $roboty
			} 
		 }
	   }
	 }
	 
	if ( $spacefound -eq $true ) {
       Write-host "But there is space to move the box! :-)" $space
	   # now let us move the box ...
	   
	 if ($dy -eq 0) { # it is a horizontal move
	   if ( $dx -gt 0 ) { # it is a move to the Right
		 Write-host "moving right"
            $Map[$space,$roboty] = "O"
	        $Map[$($robotx + $dx),$($roboty + $dy)] = "@"
	        $Map[$robotx,$roboty] = "."
	        $robotx = $robotx + $dx
	        $roboty = $roboty + $dy
	   } else { # it is a move to the Left
	     Write-host "moving left"
		    $Map[$space,$roboty] = "O"
	        $Map[$($robotx + $dx),$($roboty + $dy)] = "@"
	        $Map[$robotx,$roboty] = "."
	        $robotx = $robotx + $dx
	        $roboty = $roboty + $dy
	   }	 
	 } else { # it is a vertical move
	 	   if ( $dy -gt 0 ) { # it is a move downwards
	       Write-host "moving down"
		    $Map[$robotx,$space] = "O"
	        $Map[$($robotx + $dx),$($roboty + $dy)] = "@"
	        $Map[$robotx,$roboty] = "."
	        $robotx = $robotx + $dx
	        $roboty = $roboty + $dy   
	
	   } else { # it is a move upwards
	 Write-host "moving up"
			    $Map[$robotx,$space] = "O"
	        $Map[$($robotx + $dx),$($roboty + $dy)] = "@"
	        $Map[$robotx,$roboty] = "."
	        $robotx = $robotx + $dx
	        $roboty = $roboty + $dy   
	   }
	 }
	   
	}		
   }
  } else {
	  Write-Host "Robot cannot move due to wall..."
  }
#PrintMap  

}

#calculate GPS sum
$answer=0
for ( $i = 1 ; $i -lt $sizex ; $i++) {
	for ( $j = 1 ; $j -lt $sizey ; $j++ ) {
	  if ( $Map[$i,$j] -eq 'O' ) { #we found a box
	    $answer = $answer + 100 * $j + $i
    }
  }
}
Write-host "Answer: " $answer

