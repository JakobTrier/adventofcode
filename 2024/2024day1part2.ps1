# By JATR, 2025.01.02
# https://adventofcode.com/2024/day/1#part2
# Load the data
$puzzledata = Get-Content 2024day1.dat

# Declare variables
$similarityScore = 0
$similarityCount = 0
[int[]]$array1 = @()
[int[]]$array2 = @()

# Split the loaded data into two seperate arrays
$puzzledata | Foreach {
  $elements =  $_.split(" ",2)
  $array1=$array1+[int]$elements[0]
  $array2=$array2+[int]$elements[1]
 }

# Calcuate the similarity score
For ($i=0; $i -lt $array1.count ; $i++) {
  $similarityCount = 0
  For ($j=0; $j -lt $array2.count ; $j++) {
   if ( $array1[$i] -eq $array2[$j] ) {
    $similarityCount=$similarityCount+1
   }
  }
  $similarityScore = $similarityScore + $similarityCount * $array1[$i]
 }

$similarityScore # 26800609
