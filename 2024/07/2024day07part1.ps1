# By JATR, 2025.09.01
# https://adventofcode.com/2024/day/7

function recursive($numbers)
{
    $elements = $numbers.split(" ")

	$test = "$([int64]$elements[0] + [int64]$elements[1])"
	if ( $elements.count -gt 2 ) {
 	  for ($i = 2; $i -lt $elements.count ; $i++) {
	    $test = $test + " $([int64]$elements[$i])"
      }
	  recursive($test)
	} else {
	 if ([int64]$test -eq [int64]$global:target -and $global:adddata -eq 1) { 
	    [int64]$global:answer = [int64]$global:answer + [int64]$test 
		$global:adddata = 0
		write-host $global:counter "OK" $test
		}
	}
	
	$test = "$([int64]$elements[0] * [int64]$elements[1])"
	if ( $elements.count -gt 2 ) {
 	  for ($i = 2; $i -lt $elements.count ; $i++) {
	    $test = $test + " $([int64]$elements[$i])"
      }
	  recursive($test)
	} else {
	 if ([int64]$test -eq [int64]$global:target -and $global:adddata -eq 1) { 
	   [int64]$global:answer = [int64]$global:answer + [int64]$test 
	   $global:adddata = 0
	   write-host $global:counter "OK" $test
	   }
	}
    }


$global:target = 190
recursive "10 19"

[int64]$global:answer = 0   # 5540634308465 is too high
                            # 5540634308362 might be correct
$global:adddata = 1
$global:counter = 0

# Load the data
$puzzledata = Get-Content C:\jatr\2024day7.dat

$puzzledata | Foreach {
	$global:counter = $global:counter + 1
    $global:adddata = 1	
	$lineelements = $_.split(":").Trim()
	[int64]$global:target = [int64]$lineelements[0]
	recursive $lineelements[1]
}
$global:answer

