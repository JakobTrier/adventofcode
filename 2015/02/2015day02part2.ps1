# By JATR, 2025.08.21
# https://adventofcode.com/2015/day/2

# Load the data
$puzzledata = Get-Content C:\jatr\2015day2.dat

$data = ($puzzledata -split "x")

# Part 2

$answer = 0

for ($i=0; $i -lt ($data.length/3) ; $i++) { # tæl fra 0 til 999 (1000 pakker)
  
  $volume = [int]$data[$($i*3)] * [int]$data[$($i*3+1)] * [int]$data[$($i*3+2)] 
 
    $ribbon = 2 * [int]$data[$i*3] + 2 * [int]$data[$i*3+1] + 2 * [int]$data[$i*3+2]
    $ribbon = $ribbon - 2 * ($data[$($i*3)..$($i*3+2)] | Measure-Object -Maximum).Maximum  

 # Write-Host $data[$i*3] "x" $data[$i*3+1] "x" $data[$i*3+2] " : " $volume $ribbon $answer
  $answer = $answer + $volume + $ribbon
 
}

$answer #2: 3842356
