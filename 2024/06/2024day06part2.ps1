# By JATR, 2025.08.28
# https://adventofcode.com/2024/day/6

# Load the data
$puzzledata = Get-Content C:\jatr\2024day6.dat
$orgpuzzledata = $puzzledata.clone() # Credit to YSPR to teach me about the clone() function!

# Vi antager at data er et rektangel

$sizex = $puzzledata[0].length
$sizey = $puzzledata.length

for ($i = 0 ; $i -lt $sizey ; $i++ ) {
  if ( $puzzledata[$i].IndexOf("^") -ne -1 ) {
    $posx = $puzzledata[$i].IndexOf("^")	# store the x position of the ^ sign 
    $posy = $i                              # store the y position of the ^ sign
	$i=$sizey # stop the search
  }
}

$possibleposx = $null # where an obstacle could be placed...
$possibleposy = $null # where an obstacle could be placed...

# This is where the guard starts: $puzzledata[$posy][$posx]
$startposx = $posx
$startposy = $posy

$directionx = 0     # op
$directiony = -1    # op

$newx = $posx + $directionx
$newy = $posy + $directiony

while ( $newx -gt -1 -and $newx -lt $sizex -and $newy -gt -1 -and $newy -lt $sizey ) { # while the guard is on the map
	if ( $puzzledata[$newy][$newx] -ne "#" ) { # if the guard is not about to walk into a wall...
	  $posx = $newx  # move to new location
	  $posy = $newy
      $puzzledata[$posy] = $puzzledata[$posy].Remove($posx,1).Insert($posx,"X") # update new location with an X
	} else { # the guard was about to walk into a wall and will now turn right
		if ( $directionx -eq 0 -and $directiony -eq -1 ) { #if guard was heading up
		   $directionx = 1     # højre
           $directiony = 0     # højre
		} elseif ( $directionx -eq 1 -and $directiony -eq 0 ) { # if guard was heading right
		   $directionx = 0     # ned
           $directiony = 1     # ned
		} elseif ( $directionx -eq 0 -and $directiony -eq 1 ) { # if guard was heading down
		   $directionx = -1    # venstre
           $directiony = 0     # venstre
		} else { # if guard was heading left
		   $directionx = 0     # op
           $directiony = -1    # op
		}	
       # Now check if the guard is still about to walk into a wall after having turned 90 degrees...
       if ( $puzzledata[$posy + $directiony][$posx + $directionx] -eq "#" ) {
	     if ( $directionx -eq 0 -and $directiony -eq -1 ) { #if guard was heading up
		   $directionx = 1     # højre
           $directiony = 0     # højre
	  	} elseif ( $directionx -eq 1 -and $directiony -eq 0 ) { # if guard was heading right
		   $directionx = 0     # ned
           $directiony = 1     # ned
		} elseif ( $directionx -eq 0 -and $directiony -eq 1 ) { # if guard was heading down
		   $directionx = -1    # venstre
           $directiony = 0     # venstre
		} else { # if guard was heading left
		   $directionx = 0     # op
           $directiony = -1    # op
		}	
	   
	   }
	}
	$newx = $posx + $directionx # next step....
    $newy = $posy + $directiony

}
 
$puzzledata[$posy] = $puzzledata[$posy].Remove($posx,1).Insert($posx,"X")

$puzzledata[$posy][$posx]

$puzzledata[$startposy] = $puzzledata[$startposy].Remove($startposx,1).Insert($startposx,".")
$puzzledata[$($startposy - 1)] = $puzzledata[$($startposy - 1)].Remove($startposx,1).Insert($startposx,".")

# Number of possible locations of extra obstacle:
# ([regex]::Matches($puzzledata, "X" )).count  

$answer = 0
$puzzledatamap =  $puzzledata.clone()


for ( $j=0 ; $j -lt $sizey ; $j++ ) {
  for ( $i=0 ; $i -lt $sizex ; $i++ ) {	
    if ( $puzzledatamap[$j][$i] -eq "X" ) { # a map with an obstacle here has to be examined
	  $puzzledata = $orgpuzzledata.clone()
	  $loopcount = 0
	  # reset start position and place "#" on the map before sending the guard running....
	$posx = $startposx 
    $posy = $startposy 
	$puzzledata[$j] = $puzzledata[$j].Remove($i,1).Insert($i,"#")  
	  
$directionx = 0     # op
$directiony = -1    # op

$newx = $posx + $directionx
$newy = $posy + $directiony
	  
	  
while ( $newx -gt -1 -and $newx -lt $sizex -and $newy -gt -1 -and $newy -lt $sizey -and $loopcount -lt 50000) { # while the guard is on the map
	if ( $puzzledata[$newy][$newx] -ne "#" ) { # if the guard is not about to walk into a wall...
	  $posx = $newx  # move to new location
	  $posy = $newy
      $puzzledata[$posy] = $puzzledata[$posy].Remove($posx,1).Insert($posx,"X") # update new location with an X
	} else { # the guard was about to walk into a wall and will now turn right
		if ( $directionx -eq 0 -and $directiony -eq -1 ) { #if guard was heading up
		   $directionx = 1     # højre
           $directiony = 0     # højre
		} elseif ( $directionx -eq 1 -and $directiony -eq 0 ) { # if guard was heading right
		   $directionx = 0     # ned
           $directiony = 1     # ned
		} elseif ( $directionx -eq 0 -and $directiony -eq 1 ) { # if guard was heading down
		   $directionx = -1    # venstre
           $directiony = 0     # venstre
		} else { # if guard was heading left
		   $directionx = 0     # op
           $directiony = -1    # op
		}	
       # Now check if the guard is still about to walk into a wall after having turned 90 degrees...
       if ( $puzzledata[$posy + $directiony][$posx + $directionx] -eq "#" ) {
	     if ( $directionx -eq 0 -and $directiony -eq -1 ) { #if guard was heading up
		   $directionx = 1     # højre
           $directiony = 0     # højre
	  	} elseif ( $directionx -eq 1 -and $directiony -eq 0 ) { # if guard was heading right
		   $directionx = 0     # ned
           $directiony = 1     # ned
		} elseif ( $directionx -eq 0 -and $directiony -eq 1 ) { # if guard was heading down
		   $directionx = -1    # venstre
           $directiony = 0     # venstre
		} else { # if guard was heading left
		   $directionx = 0     # op
           $directiony = -1    # op
		}	
	   
	   }
	}
	$newx = $posx + $directionx # next step....
    $newy = $posy + $directiony
	$loopcount++
}
	  
	  write-host $loopcount
	  if ($loopcount -gt 49998) { 
	   $answer++    
	  }
	}
  }
}

Write-Host "Obstacles can be placed at"$answer" locations" # 4284 is too high. loop=20000 -> 1793
	
