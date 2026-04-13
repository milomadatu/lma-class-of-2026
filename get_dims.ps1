Add-Type -AssemblyName PresentationCore
$files = @('Twins','CholoSquat','TheMack','FunniestJoke','Besties','LayUp','Warming','Twizzies','FlexedUp','Lonzo','LockedTFIn','WhoseHouse','PleaseSpeed','HugItOut','Cluely','Raymen','LastGame','Kawaii')
foreach ($name in $files) {
  $path = "c:\Users\madol\Downloads\LMA26Website\images\favs\$name.webp"
  $uri = New-Object System.Uri($path)
  $dec = [System.Windows.Media.Imaging.BitmapDecoder]::Create($uri, 'None', 'OnLoad')
  $f = $dec.Frames[0]
  $o = if ($f.PixelHeight -gt $f.PixelWidth) { 'portrait' } else { 'landscape' }
  Write-Output ("$name : " + $f.PixelWidth + "x" + $f.PixelHeight + " $o")
}
