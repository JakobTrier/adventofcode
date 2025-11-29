# By JATR, 2025.08.29
# https://adventofcode.com/2022/day/2

# Load the data
$puzzledata = Get-Content 2022day2.dat
$answer = 0

$puzzledata | Foreach {
  switch ($_) {
	"A Y" { $answer = $answer + 6 + 2 }	 # Rock vs Paper(2)
	"A X" { $answer = $answer + 3 + 1 }	 # Rock vs Rock(1)
    "A Z" { $answer = $answer + 0 + 3 }	 # Rock vs Scissors(3)
    "B Y" { $answer = $answer + 3 + 2 }  # Paper vs Paper(2)
    "B X" { $answer = $answer + 0 + 1 }	 # Paper vs Rock(1)
    "B Z" { $answer = $answer + 6 + 3 }	 # Paper vs Scissors(3)
    "C Y" { $answer = $answer + 0 + 2 }	 # Scissors vs Paper(2)
    "C X" { $answer = $answer + 6 + 1 }	 # Scissors vs Rock(1)
    "C Z" { $answer = $answer + 3 + 3 }	 # Scissors vs Scissors(3)
	}
}
Write-host "The answer is"$answer
