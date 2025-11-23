# By JATR, 2025.11.23
# https://adventofcode.com/2024/day/22

# Load the data
write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Loading data" 
$puzzledata = Get-Content 2024day22.dat 

$answer = 0

$puzzledata | foreach {
  $number = [bigint]$_
    for ($i = 0 ; $i -lt 2000 ; $i++ ) {
      $number = ($number * 64) -bxor $number       # *64 & mix
      $number = $number % 16777216                 # prune
      $number = [int]($number / 32) -bxor $number  # /32 & mix
      $number = $number % 16777216                 # prune
      $number = ($number * 2048) -bxor $number     # *2048 & mix
      $number = $number % 16777216                 # prune
    }
  $answer = $answer + $number
  }
  
Write-host $(get-date -format "yyyy.MM.dd HH:mm:ss") "Answer: " $answer
