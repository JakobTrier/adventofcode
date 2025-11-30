# By JATR, 2025.08.29
# https://adventofcode.com/2021/day/2

# Load the data
$puzzledata = Get-Content 2021day2.dat

$x = 0
$y = 0

$puzzledata | Foreach {
   $move   = ($_).split(" ")[0]
   $amount = ($_).split(" ")[1]
   
   	    switch ($move) {
		  forward   { $x = $x + $amount }	
		  down      { $y = $y + $amount }	
		  up        { $y = $y - $amount }	
		}
}

$answer = $x * $y

Write-host "The answer is"$answer
