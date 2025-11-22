# By JATR, 2025.09.04
# https://adventofcode.com/2016/day/2

# Load the data
$puzzledata = Get-Content 2016day2.dat

$answer = ""
$number = "5"

$puzzledata | Foreach {
  for ($i=0 ; $i -lt $_.length ; $i++ ) {
    switch ($_[$i]) {
		D {
		  switch ($number) {
			1 { $number = "3"}  
			2 { $number = "6"}
			3 { $number = "7"}
			4 { $number = "8"}
			6 { $number = "A"}
			7 { $number = "B"}
			8 { $number = "C"}
			B { $number = "D"}			
		  }
		}
        U {
		  switch ($number) {
			3 { $number = "1"}  
			6 { $number = "2"}
			7 { $number = "3"}
			8 { $number = "4"}
			A { $number = "6"}
			B { $number = "7"}
			C { $number = "8"}
			D { $number = "B"}			
		  }			  
		}
        L {
		  switch ($number) {
			3 { $number = "2"}  
			4 { $number = "3"}
			6 { $number = "5"}
			7 { $number = "6"}
			8 { $number = "7"}
			9 { $number = "8"}
			B { $number = "A"}
			C { $number = "B"}			
		  }
		}
        R {
		  switch ($number) {
			2 { $number = "3"}  
			3 { $number = "4"}
			5 { $number = "6"}
			6 { $number = "7"}
			7 { $number = "8"}
			8 { $number = "9"}
			A { $number = "B"}
			B { $number = "C"}			
		    }
          }			  			
		}	
	}
  $answer = $answer + [string]$number
}
Write-host $answer

