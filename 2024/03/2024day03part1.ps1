$puzzledata = Get-Content 2024day3.dat

$regex = [regex] '(mul\(\d+,\d+\))'

$allMatches = $regex.Matches($puzzledata)
$total = 0

foreach ($match in $allMatches) {
    $tempStr = $match.Value
    $values = $tempStr.Replace("mul(","").Replace(")","")
    $thisSum = [int]$values.Split(",")[0] * [int]$values.Split(",")[1]
    $total += $thisSum
}

$total
