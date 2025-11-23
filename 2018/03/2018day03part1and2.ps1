# set-ExecutionPolicy -ExecutionPolicy Unrestricted
# By JATR, 2025.10.30
# https://adventofcode.com/2018/day/3

# Load the data
$puzzledata = Get-Content 2018day3.dat

# We start by finding out how large a grid we need..

$maxx = 0
$maxy = 0

$puzzledata | Foreach {
  $startx = [int]($_).split(":")[0].split("@")[1].split(",")[0]
  $starty = [int]($_).split(":")[0].split("@")[1].split(",")[1]
  $plusx = [int]($_).split(":")[1].split("x")[0]
  $plusy = [int]($_).split(":")[1].split("x")[1]
  if ( ($startx + $plusx) -gt $maxx ) { 
    $maxx = $startx + $plusx
  }
  if ( ($starty + $plusy) -gt $maxy ) { 
    $maxy = $starty + $plusy
  }
}

#now we know how large a grid to create.... so let us do it
$TheGrid = New-Object -TypeName 'Double[,]' -ArgumentList $maxx,$maxy
 # write-host " !---> " $maxx " " $maxy

# Now it is time to fill the grid with data...

$puzzledata | Foreach {
  $id     = [int]($_).split("@")[0].split("#")[1]
  $startx = [int]($_).split(":")[0].split("@")[1].split(",")[0]
  $starty = [int]($_).split(":")[0].split("@")[1].split(",")[1]
  $plusx  = [int]($_).split(":")[1].split("x")[0]
  $plusy  = [int]($_).split(":")[1].split("x")[1]
  for ($i = $startx ; $i -lt ($startx + $plusx) ; $i++ ) {
	  for ($j = $starty ; $j -lt ($starty + $plusy) ; $j++ ) {
	      if ( $TheGrid[$i,$j] -eq 0 ) {
			  $TheGrid[$i,$j] = $id
		  } else {
			  $TheGrid[$i,$j] = -1
		  }		  
	  }
  }
 }

# Now count the fields with overlap (-1)

$answer = 0
for ($i = 0 ; $i -lt $maxx ; $i++ ) {
	  for ($j = 0 ; $j -lt $maxy ; $j++ ) {
          if ( $TheGrid[$i,$j] -eq -1 ) {
               $answer++
		  }
	  }
}
write-host "Answer #1: " $answer

$answer = 0

$puzzledata | Foreach {
  $id     = [int]($_).split("@")[0].split("#")[1]
  $startx = [int]($_).split(":")[0].split("@")[1].split(",")[0]
  $starty = [int]($_).split(":")[0].split("@")[1].split(",")[1]
  $plusx  = [int]($_).split(":")[1].split("x")[0]
  $plusy  = [int]($_).split(":")[1].split("x")[1]
  for ($i = $startx ; $i -lt ($startx + $plusx) ; $i++ ) {
	  for ($j = $starty ; $j -lt ($starty + $plusy) ; $j++ ) {
	      if ( $TheGrid[$i,$j] -eq -1 ) {
			 $i =  $startx + $plusx
			 $j =  $starty + $plusy
			 $answer = -1
		  }		  
	  } 
  }
  
 if ($answer -ne -1 ) {
       write-host "Answer #2 " $id
	 } else {
		 $answer = 0
	 }
 }
