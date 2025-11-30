# By JATR, 2025.08.29
# https://adventofcode.com/2021/day/2

# Load the data
$puzzledata = Get-Content 2021day2.dat

$x = 0
$y = 0
$aim = 0

$puzzledata | Foreach {
   $move   = ($_).split(" ")[0]
   $amount = ($_).split(" ")[1]
   
   	    switch ($move) {
		  forward   { 
		               $x = [int]$x + [int]$amount 
					   $y = [int]$y + ( [int]$amount * [int]$aim )
					   }	
		  down      { $aim = [int]$aim + [int]$amount }	
		  up        { $aim = [int]$aim - [int]$amount }	
		}
}

$answer = $x * $y

Write-host "The answer is"$answer
