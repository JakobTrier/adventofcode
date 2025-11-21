# By JATR, 2025.08.27-28
# https://adventofcode.com/2024/day/5#part2

# Load the data
$puzzledata = Get-Content C:\jatr\2024day5.dat

# Store page rules in $pagerule variable and page numbers $pagenumbers variable
$pagerule = $null
$pagenumbers = $null

$puzzledata | Foreach {
  if ( $_ -Match "\|" ) {  # A line is treated as a rule line if it contains the character "|"	
	  $pagerule = $pagerule + @($_)
  }
  if ( $_ -Match "," ) {  # A line is treated as a page numbers line if it contains the character ","	
	  $pagenumbers = $pagenumbers + @($_)
  }
}


$anotheranswer = 0 

$pagenumbers | Foreach { # Check hver enkelt linje med side nr.
    $pagenumbersareinorder = 1 # we assume pages are ordered correctly
	$pageelements = $_.split(",")

	for ($i=0; $i -lt ( $pageelements.count - 1 ) ; $i++) { # check om hver enkelt side overholder regler
	   $pagerule | Foreach { #hvis side tallet er det sidste i en regel så skal vi checke om det første tal i regelen er senere i rækken.....
	     $rule = $_.split("\|")
	     if ( $pageelements[$i] -eq $rule[1] ) {
			 for ($j=($i + 1); ( $j -lt $pageelements.count ); $j++) {
				 if ($rule[0] -eq $pageelements[$j]) {
					 $pagenumbersareinorder = 0 # siderne er ikke ordnet korrekt
					# write-host $pageelements " broken rule:" $_
					 $j = $pageelements.count # stop looking at this line...
					 $i = $pageelements.count
					 
					 # ----------------  Now order the data correctly !!
					
					for ( $snyd=0 ; $snyd -lt 110 ; $snyd++ ) {
					 $pagerule | Foreach { 
					   $disorderfound = 0
					   $rule = $_.split("\|")
                       for ($ii=0; $ii -lt ( $pageelements.count - 1 ) ; $ii++) {	                    
						if ( $pageelements[$ii] -eq $rule[1] ) {
			               for ($jj=($ii + 1); ( $jj -lt $pageelements.count ); $jj++) {
				             if ($rule[0] -eq $pageelements[$jj]) {
							# write-host "Swapping" $pageelements[$jj] $pageelements[$ii]
				               $temp = $pageelements[$jj]
					           $pageelements[$jj] = $pageelements[$ii]
					           $pageelements[$ii] = $temp
							  
					         }
					       }
						 }
					   }
					 }
					}
					write-host $pageelements
					 # ----------------  Done ordering the data correctly !!
					 
					 $anotheranswer = $anotheranswer + $pageelements[(((($pageelements).count + 1) / 2)-1)]

					# write-host $pageelements
				 }
			 }		 
		 }
	   }
	
}

}
#YzN8epXUj8uWLx7o

Write-Host "Part 2 answer:" $anotheranswer   # 5273 is too high, maybe 5180
