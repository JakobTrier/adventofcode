# By JATR, 2025.08.26-27
# https://adventofcode.com/2024/day/5

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

$answer = 0

$pagenumbers | Foreach { # Check hver enkelt linje med side nr.
    $pagenumbersareinorder = 1 # we assume pages are ordered correctly
	$pageelements = $_.split(",")
	for ($i=0; $i -lt ( $pageelements.count - 1 ) ; $i++) { # check om hver enkelt side overholder regler
	   $pagerule | Foreach { #hvis side tallet er det sidste i en regel så skal vi checke om det første tal i regelen er senere i rækken.....
	     $rule = $_.split("\|")
	     if ( $pageelements[$i] -eq $rule[1] ) {
			 for ($j=($i + 1); ( $j -lt $pageelements.count ); $j++) {
				 if ($rule[0] -eq $pageelements[$j]) {
					 $pagenumbersareinorder = 0 # øv, siderne er ikke ordnet korrekt
				 }
			 }		 
		 }
	   }
	}
	if ($pagenumbersareinorder -eq 1) { # Add the middle page number to the answer if the pages are in order
		$answer = $answer + $pageelements[(((($pageelements).count + 1) / 2)-1)]
	}
}

$answer
