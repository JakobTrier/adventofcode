# By JATR, 2025.01.02
# https://adventofcode.com/2024/day/1
# Load the data
$puzzledata = Get-Content 2024day1.dat

# Declare variables
$total = 0
[int[]]$array1 = @()
[int[]]$array2 = @()

# Split the loaded data into two seperate arrays
$puzzledata | Foreach {
  $elements =  $_.split(" ",2)
  $array1=$array1+[int]$elements[0]
  $array2=$array2+[int]$elements[1]
 }

# Sort data in the arrays
$array1=$array1 | Sort-Object
$array2=$array2 | Sort-Object

# Calcuate the sum of differences
For ($i=0; $i -lt $array1.count ; $i++) {
  $total=$total+[Math]::Abs($array1[$i]-$array2[$i])
 }

$total # 1530215
