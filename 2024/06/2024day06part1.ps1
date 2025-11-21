# By JATR, 2025.08.28
# https://adventofcode.com/2024/day/6

# Load the data
$puzzledata = Get-Content C:\jatr\2024day6.dat

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

# This is where the guard starts
$puzzledata[$posy][$posx]
$puzzledata[$posy] = $puzzledata[$posy].Remove($posx,1).Insert($posx,"X") # mark location with an X

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
	  $newx = $posx + $directionx # after turning the guard wants to walk in a new direction
      $newy = $posy + $directiony	
	}
	
#	write-host $posx $posy 
	
	$newx = $posx + $directionx # next step....
    $newy = $posy + $directiony
}
write-host OutOfBounds
 
$puzzledata[$posy] = $puzzledata[$posy].Remove($posx,1).Insert($posx,"X")

$puzzledata[$posy][$posx]

([regex]::Matches($puzzledata, "X" )).count # The Answer to Part 1
