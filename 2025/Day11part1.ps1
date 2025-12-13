# By JATR, 2025.12.11
# https://adventofcode.com/2025/day/11

$puzzledata  = Get-Content 2025day11.dat                                     # Load the data, it must be copied from https://adventofcode.com/2025/day/11/input and saved in a file called 2025day11.dat
$answer1     = 0                                                             # Declare variable used to store answer to part 1

$dc = @{}                                                                    # Array to store all Device Connections

$puzzledata | foreach-object {                                               # Run through all the lines in the puzzle input
  $device      = $_.split(":")[0].Trim()                                     # Pick the decive
  $connections = $_.split(":")[1].Trim().split(" ")                          # Pick the connections
  $dc[$device] = $connections                                                # Store connections for the device
}

$global:PathCache = @{}                                                      # Initialize cache for memoisation

function FindPath ([string]$device) {                                        # Define recursive function with memoisation
  if ($PathCache.ContainsKey($device)) {                                     # First check the cache
    return $PathCache[$device]
  }
  if ($device -eq 'out') {                                                   # Check if we reached the end of the path
    $n = 1
  } else {                                                                   # Search for a way out
    foreach ($way in $dc[$device]) {
      $n += [int](FindPath $way)
    }  
  }
  $PathCache[$device] = $n                                                   # Store result in cache   
  return $n
}

$answer1 = FindPath 'you'
Write-host "Part 1 answer:"$answer1                                          # Write the answer to part 1 to the console
