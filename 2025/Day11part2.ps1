# By JATR, 2025.12.11
# https://adventofcode.com/2025/day/11#part2

$puzzledata  = Get-Content 2025day11.dat                                     # Load the data, it must be copied from https://adventofcode.com/2025/day/11/input and saved in a file called 2025day11.dat
$answer1     = 0                                                             # Declare variable used to store answer to part 1

$dc = @{}                                                                    # Array to store all Device Connections

$puzzledata | foreach-object {                                               # Run through all the lines in the puzzle input
  $device      = $_.split(":")[0].Trim()                                     # Pick the decive
  $connections = $_.split(":")[1].Trim().split(" ")                          # Pick the connections
  $dc[$device] = $connections                                                # Store connections for the device
}

$global:PathCache = @{}                                                      # Initialize cache for memoisation

function FindPath ([string]$device,[bool]$seenDAC,[bool]$seenFFT) {          # Define recursive function with memoisation
  $cacheKey = "$device|$seenDAC|$seenFFT"
  if ($PathCache.ContainsKey($cacheKey)) {                                   # First check the cache
    return [bigint]$PathCache[$cacheKey]
  }

  if ($device -eq 'out') {                                                   # Check if we reached the end of the path
    if ($seenDAC -and $seenFFT) {                                            # Check if we passed both DAC and FFT
	  $n = 1                                                                 # Add 1 if we did
	} else {
      $n = 0                                                                 # Add 0 if DAC and FFT was not passed
    }
	$PathCache[$cacheKey] = $n                                               # Store result in cache
	return $n
  } 
  
  $sum = 0
  if ($dc.ContainsKey($device)) {
    foreach ($way in $dc[$device]) {                                         # Search for a way out
      $newSeenDAC = $seenDAC -or ($way -eq 'dac')                            # Make sure we pass on information on wether we passed DAC or not
      $newSeenFFT = $seenFFT -or ($way -eq 'fft')                            # Make sure we pass on information on wether we passed FFT or not
      $sum += [bigint](FindPath $way $newSeenDAC $newSeenFFT)
    }
  }

  $PathCache[$cacheKey] = $sum                                               # Store result in cache
  return [bigint]$sum 
}

$answer2 = FindPath 'svr' $false $false
Write-host "Part 1 answer:"$answer2                                          # Write the answer to part 2 to the console
