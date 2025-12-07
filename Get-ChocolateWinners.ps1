# By JATR, 2025.11.30-2025.12.07
#   Using data from: https://adventofcode.com/2025/leaderboard/private/view/4911913.json?view_key=e98ced22
param([Int]$winners=3)           # Default number of winners is : 3 

Write-host "Script executed at" $(get-date -format "yyyy.MM.dd HH:mm:ss")

$id                 = @()    # Declare array used to store ID of each participant
$name               = @()    # Declare array used to store name of each participant
$stars              = @()    # Declare array used to store number of stars of each participant
$time               = @()    # Declare array used to store time of latest star of each participant
$lodder             = @()    # Declare array used to store lots of each participant
$userswithzerostars = $false # Declare variable to keep track of is there are participants with 0 stars
$winnerlod          = @()    # Declare variable to keep track of lots
 
Write-host ""
if ((test-path 2025participants.dat) -eq $false ) { # if the file is not there then download it
  Write-host "Downloading JSON file from https://adventofcode.com/2025/leaderboard/private/view/4911913.json?view_key=e98ced22"
  Invoke-WebRequest -Uri "https://adventofcode.com/2025/leaderboard/private/view/4911913.json?view_key=e98ced22" -OutFile '2025participants.dat'    # Download the latest data from the web and store it in a local file
} else { # if the file is there	check how old it is
  $lastWrite = (get-item '2025participants.dat').LastWriteTime
  $timespan  = new-timespan -minutes 15
  if (((get-date) - $lastWrite) -gt $timespan) { # what if the file is not there?
	Write-host "JSON file is older than 15 minutes. Downloading a new"
	Invoke-WebRequest -Uri "https://adventofcode.com/2025/leaderboard/private/view/4911913.json?view_key=e98ced22" -OutFile '2025participants.dat'    # Download the latest data from the web and store it in a local file
  } else {
    Write-host "JSON file is less than 15 minutes old (" $((((get-date) - $lastWrite))).minutes "). Using old file."
  }
}

(Get-Content 2025participants.dat -Encoding UTF8 | ConvertFrom-Json).psobject.properties | select name,value | foreach { # Pull the names, their ID and number of stars for all participants into 3 arrays.
  if ( $_.Name -eq 'members' ) { 
    $name  += $_.Value.psobject.properties.Value.name
    $stars += $_.Value.psobject.properties.Value.stars
    $id    += $_.Value.psobject.properties.Value.id
	$time  += $_.Value.psobject.properties.Value.last_star_ts
	if ( $_.Value.psobject.properties.Value.stars -eq '0' ) { $userswithzerostars = $true }
  }
}

for ( $i = 0 ; $i -lt $id.length ; $i++ ){ # If there are annonymous users on the leaderboard give them the name "anonymous user" plus their ID.
  if ( $name[$i].length -eq 0) { $name[$i] = '(anonymous user #' +  $($id[$i]) + ')'}
}
 write-host ""
Write-Host $id.count -nonewline -ForegroundColor blue
Write-host " participants got " -nonewline
write-host ($stars | measure-object -sum).sum -ForegroundColor yellow -nonewline
write-host " stars." # Write to screen how many participated and how many stars they got in total 

for ( $j = 0 ; $j -lt $($stars.length - 1) ; $j++ ){  # Sort the participants according to name
  for ( $i = 0 ; $i -lt $($stars.length - 1) ; $i++ ){
	if ( $name[$i] -gt $name[$($i + 1)]) { 
      $temp = $stars[$i]
      $stars[$i] = $stars[$($i + 1)]
      $stars[$($i + 1)] = $temp
	  $temp = $name[$i]
      $name[$i] = $name[$($i + 1)]
	  $name[$($i + 1)] = $temp
	  $temp = $id[$i]
      $id[$i] = $id[$($i + 1)]
	  $id[$($i + 1)] = $temp
	  $temp = $time[$i]
      $time[$i] = $time[$($i + 1)]
	  $time[$($i + 1)] = $temp
    }
  }
}

for ( $j = 0 ; $j -lt $($stars.length - 1) ; $j++ ){  # Sort the participants according to time of last star
  for ( $i = 0 ; $i -lt $($stars.length - 1) ; $i++ ){
	if ( [int]$time[$i] -gt [int]$time[$($i + 1)]) { 
      $temp = $stars[$i]
      $stars[$i] = $stars[$($i + 1)]
      $stars[$($i + 1)] = $temp
	  $temp = $name[$i]
      $name[$i] = $name[$($i + 1)]
	  $name[$($i + 1)] = $temp
	  $temp = $id[$i]
      $id[$i] = $id[$($i + 1)]
	  $id[$($i + 1)] = $temp
	  $temp = $time[$i]
      $time[$i] = $time[$($i + 1)]
	  $time[$($i + 1)] = $temp
    }
  }
}

for ( $j = 0 ; $j -lt $($stars.length - 1) ; $j++ ){  # Sort the participants according to number of stars (most stars at top (index=0))
  for ( $i = 0 ; $i -lt $($stars.length - 1) ; $i++ ){
	if ( [int]$stars[$i] -lt [int]$stars[$($i + 1)]) { 
      $temp = $stars[$i]
      $stars[$i] = $stars[$($i + 1)]
      $stars[$($i + 1)] = $temp
	  $temp = $name[$i]
      $name[$i] = $name[$($i + 1)]
	  $name[$($i + 1)] = $temp
	  $temp = $id[$i]
      $id[$i] = $id[$($i + 1)]
	  $id[$($i + 1)] = $temp
	  $temp = $time[$i]
      $time[$i] = $time[$($i + 1)]
	  $time[$($i + 1)] = $temp
    }
  }
}

if ( $userswithzerostars ) {
	write-host ""
  Write-Host "The participants without stars are:" # List all the participants who have not gotten any stars
  for ( $f = 0 ; $f -lt $id.count ;$f++ ) {
    if ($stars[$f] -eq '0') { Write-Host " "$name[$f] }
  }
}
write-host ""
Write-Host "The participants with stars are:" # List all the participants who have gotten stars. Both write their user name as well as number of stars they have gotten
$neweststar = 0
$neweststarname = ""

$currentlot = 0
for ( $f = 0 ; $f -lt $id.count ;$f++ ) {
  
  if ($stars[$f] -ne '0') { 
      $timejump = [int]$time[$f]
	  if ($stars[$f] -ne '1') { 
        Write-Host " "$name[$f]"with"$stars[$f]"stars ( latest" $((Get-Date -Year 1970 -Month 1 -Day 1 -Hour 1 -Minute 0 -Second 0).AddSeconds($timejump)|Get-Date -Format "yyyy.MM.dd HH:mm:ss")") [lots:" $currentlot "-" $($currentlot+$stars[$f]-1)  "]"
	  } else { # only 1 star
	    Write-Host " "$name[$f]"with"$stars[$f]"star ( latest" $((Get-Date -Year 1970 -Month 1 -Day 1 -Hour 1 -Minute 0 -Second 0).AddSeconds($timejump)|Get-Date -Format "yyyy.MM.dd HH:mm:ss")") [lot:" $currentlot "]"
	  }
	  if ([int]$time[$f] -gt $neweststar ) {
		  $neweststar = [int]$time[$f]
		  $neweststarname =  $name[$f]
	  }
	}
	$currentlot += $stars[$f]
}
write-host ""
write-host "Latest star was made at"$((Get-Date -Year 1970 -Month 1 -Day 1 -Hour 1 -Minute 0 -Second 0).AddSeconds($neweststar)|Get-Date -Format "yyyy.MM.dd HH:mm:ss")"by" $neweststarname

for ( $f = 0 ; $f -lt [int]$stars.count ;$f++ ) { # Now create a lot for each star 
  if ($stars[$f] -ne '0') {
    for ( $j = 0 ; $j -lt ($stars[$f]) ; $j++ ) {   
      $lodder += $name[$f]
    }
  }
}

$f =0
while ($f -lt 3) {
 $winnerlot = get-random -minimum 0 -maximum $($lodder.length) # Draw of lots. Get a random number which will determine what lot wins the draw
 if  ($f -eq 0 ) { 
    $winnerlod +=  $winnerlot
 }
 if ( $f -eq 1 ) {
	# Write-host "1: " $lodder[$winnerlot] " / (" $lodder[($winnerlod[($f-1)])] ")"
	if ( $lodder[$winnerlot] -eq $lodder[($winnerlod[($f-1)])] ) { $f--} else { $winnerlod +=  $winnerlot }
   } 
 if ( $f -eq 2 ) {
	# Write-host "2: " $lodder[$winnerlot] " / (" $lodder[($winnerlod[($f-1)])] " / " $lodder[($winnerlod[($f-2)])] ")"
	if ( ($lodder[$winnerlot] -eq $lodder[($winnerlod[($f-1)])]) -or ($lodder[$winnerlot] -eq $lodder[($winnerlod[($f-2)])] )) { $f--} else { $winnerlod +=  $winnerlot }
   }  
  $f++ 
 }

write-host ""

if ($winners -eq 1) { # The script will either display 3 winners [default], 2 winners or 1 winner 
  $winners=1
  Write-host "The winner is:  " -nonewline
  } else {
  Write-host "The winners are:  " -nonewline
  if ($winners -ne 2 -and $winners -ne 3 ) { $winners = 3 }
}

for ( $f = 0 ; $f -lt $winners ; $f++ ) {
$top=""
$bottom=""
 for ( $i = 0 ; $i -lt ($($lodder[$winnerlod[$f]])).length ; $i++ ) {
   $top=$top+"v"
  $bottom=$bottom + "^"
}
write-host ""
write-host "                " $top  
write-host "               > " -nonewline
Write-host "$($lodder[$winnerlod[$f]])" -ForegroundColor DarkGreen -nonewline
Write-host " <      (lot number $($winnerlod[$f]))" # Write to screen who has the winning lot and the number of the lot
write-host "                " $bottom
}
