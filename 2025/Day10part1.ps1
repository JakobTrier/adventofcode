# By JATR, 2025.12.10
# https://adventofcode.com/2025/day/10

$puzzledata  = Get-Content 2025day10.dat                                     # Load the data, it must be copied from https://adventofcode.com/2025/day/10/input and saved in a file called 2025day10.dat
$answer1     = 0                                                             # Declare variable used to store answer to part 1

$puzzledata | foreach-object {
  $li = 0                                                                    # Light indicator variable reset
  $length = ($_.split(" ")[0]).length                                        # Length of the light indicator including brackets []
  for ($f = 0 ; $f -lt $($length-2) ; $f++ ) {                               # Convert light indicator string to binary number
    if ($_[$($f+1)] -eq '#') {
      $li += [math]::Pow(2, $f)
    }
  }     

  $b=@()                                                                     # Arrays for buttons
  $numberofbuttons = ([regex]::Matches($_, " " )).count - 1                  # Number of buttons 
  for ($f = 0 ; $f -lt $numberofbuttons ; $f++ ) {                           # Convert each button to a binary number...
    $buttonnumbers = ($_.split(" ")[$($f+1)]).replace("(","").replace(")","").split(",") # Variable to store all the numbers per button as they are written in the input file
    $buttonnumber  = 0                                                       # Start with 0 and then add up all the numbers as a binary number
    for ($ff = 0 ; $ff -lt $buttonnumbers.count ; $ff++) {
      $buttonnumber += [int]([math]::Pow(2, [int]$($buttonnumbers[$ff])))
    }
    $b += $buttonnumber                                                      # Add the binary button number to the array of buttons
  }
	 
  $score = $numberofbuttons                                                  # Maximum number of pushes is one per button                                                  
  for ( $f = 0 ; $f -lt [math]::Pow(2, $numberofbuttons) ; $f++ ) {          # Try all 2^buttons combinations and record how many buttons are pushed in each successfull try
    $result = 0                                                              # How the light indicators look
    $result_score = 0                                                        # Number of buttons pushed
    for ($i = 0; $i -lt $numberofbuttons; $i++) {
      if (($f -band [int][math]::Pow(2, $i)) -ne 0) {                        # If bit $i of $f is set
        $result = $result -bxor $b[$i]                                       # Calculate hos the light indicators look after having pushed button $b[$i]
        $result_score++                                                      # Add to the number of times a button has been pushed
      }
    }
    if ($result -eq $li) {                                                   # Check if our result is identical to the desired result ($li)
      if ($result_score -lt $score) { 
        $score = $result_score                                               # We found the best solution so far, let us store it
      }
    }
  }
  $answer1 += $score	
}
Write-host "Part 1 answer:"$answer1                                          # Write the answer to part 1 to the console
