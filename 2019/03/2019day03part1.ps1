# By JATR, 2025.11.03-04
# https://adventofcode.com/2019/day/3

# Load the data
$puzzledata = Get-Content 2019day3.dat

# We start by finding out how large a grid we need..

$maxx = 0
$maxy = 0

$minx = 0
$miny = 0

$puzzledata | Foreach { 
 $xpos = 0
 $ypos = 0
 $_.split(",") | Foreach {
  $number = $_.Substring(1)
  switch ($_[0])
  {
    "L"	{ 
		   $xpos = $xpos - $number
		   if ($xpos -lt $minx) { $minx = $xpos }
		} 
	"R" {
		   $xpos = $xpos + $number
		   if ($xpos -gt $maxx) { $maxx = $xpos }
	    }
	"D" {
		   $ypos = $ypos - $number
		   if ($ypos -lt $miny) { $miny = $ypos }
	    }
	"U" {
		   $ypos = $ypos + $number
		   if ($ypos -gt $maxy) { $maxy = $ypos }
	    }
  }
 }
}

$sizex = $maxx - $minx
$sizey = $maxy - $miny

$mindist = $sizex + $sizey

Write-Host "("$sizex","$sizey ")"
# ( 12534,18459 )
# Create the matrix...
$Multi = New-Object -TypeName 'Int[,]' -ArgumentList ($sizex+1),($sizey+1)


# x: -7606  -> 4928
# y: -15667 -> 2792

# where is origon.... 
$ox = 0 - $minx 
$oy = 0 - $miny 

$Multi[$ox,$oy] = 1

# Draw line 1

# we start at origon
 $xpos = $ox
 $ypos = $oy
 $puzzledata[0].split(",") | Foreach { 
 Write-host "(" $xpos "," $ypos ")" $_
 
 $number = $_.Substring(1)
  switch ($_[0])
  {
    "L"	{ 
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $xpos--
			 $Multi[$xpos,$ypos] = 1
		   }
		} 
	"R" {
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $xpos++
			 $Multi[$xpos,$ypos] = 1
		   }
	    }
	"D" {
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $ypos--
			 $Multi[$xpos,$ypos] = 1
		   }
	    }
	"U" {
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $ypos++
			 $Multi[$xpos,$ypos] = 1
		   }
	    }
  }

 }

# Find where line 2 crosses line 1..

# we start at origon - again

 $xpos = $ox
 $ypos = $oy
 $puzzledata[1].split(",") | Foreach { 

$number = $_.Substring(1)
  switch ($_[0])
  {
    "L"	{ 
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $xpos--
			 if ( $Multi[$xpos,$ypos] -eq 1 ) {
				Write-host "X: (" $xpos "," $ypos ") Dist: " $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy))  
                if ( $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) -lt $mindist) { $mindist = $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) } 		
			 }
		   }
		} 
	"R" {
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $xpos++
			 if ( $Multi[$xpos,$ypos] -eq 1 ) {
				Write-host "X: (" $xpos "," $ypos ") Dist: " $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy))  
                if ( $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) -lt $mindist) { $mindist = $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) }				
			 }
		   }
	    }
	"D" {
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $ypos--
			 if ( $Multi[$xpos,$ypos] -eq 1 ) {
				Write-host "X: (" $xpos "," $ypos ") Dist: " $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy))      
				if ( $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) -lt $mindist) { $mindist = $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) }
			 }
		   }
	    }
	"U" {
		   for ($i = 0 ; $i -lt $number ; $i++) { 
		     $ypos++
			 if ( $Multi[$xpos,$ypos] -eq 1 ) {
				Write-host "X: (" $xpos "," $ypos ") Dist: " $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy))  
				if ( $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) -lt $mindist) { $mindist = $([Math]::Abs($xpos-$ox) + [Math]::Abs($ypos-$oy)) }
			 }
		   }
	    }
  }

 }
 
 Write-host "Answer: " $mindist
