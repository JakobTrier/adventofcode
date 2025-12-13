# By JATR, 2025.12.13
#  Using data from: https://adventofcode.com/2025/leaderboard/private/view/4911913.json?view_key=e98ced22

$FilePath = "2025participants.dat"
$DownloadFile = $true

if (Test-Path -Path $FilePath) { # if the file is not there then download it
  $lastWrite = (Get-Item -Path $FilePath).LastWriteTime
  $timespan  = New-TimeSpan -Start $lastWrite -End (get-date)
  if ($timespan.TotalMinutes -lt 15) {
    Write-host "JSON file is only $([int]$timespan.TotalMinutes) minutes old. Using old file."
    $DownloadFile = $false
  }
  else {
    Write-host "JSON file is older than 15 minutes. Downloading a new."
  }
}
else {
  Write-host "JSON file not found."
}

if ($DownloadFile) {
  Invoke-WebRequest -Uri "https://adventofcode.com/2025/leaderboard/private/view/4911913.json?view_key=e98ced22" -OutFile $FilePath    # Download the latest data from the web and store it in a local file
} 

$json = Get-Content $FilePath -Encoding UTF8 | ConvertFrom-Json | Select-Object -Expand Members

$list = $json.psobject.properties.value | foreach {
  if ( $_.name.length -ne 0 ) {   
    if ( $_.stars -ne 0 ) {
      for ( $s = 0 ; $s -lt 25 ; $s++ ) {
        if ( $_.completion_day_level.$s -ne $null ) {
          for ( $l = 1 ; $l -le 2 ; $l++ ) {
		    if ( $_.completion_day_level.$s.$l -ne $null ) {
              $info = $_.completion_day_level.$s.$l
		      [PSCustomObject]@{
                name  = $_.name
                star  =  $s
                part  = $l
                stars = $_.stars
                index = $info.star_index
                ts    = $info.get_star_ts
               }
              }
          }
        }
      }
    }
  }
}

$list | sort index | select-object name,star,part,index,ts,stars | Format-Table @{Name="Index";E={$($_.index +1) }},@{Name="Date and time";E={$((Get-Date -Year 1970 -Month 1 -Day 1 -Hour 1 -Minute 0 -Second 0).AddSeconds($_.ts)|Get-Date -Format "yyyy.MM.dd HH:mm:ss")}},@{Name="Star";E={[string]$_.star+"."+[string]$_.part};Alignment="right"},@{Name="Participant (#stars)";E={$_.name + " ($($_.stars))"}}
