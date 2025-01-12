# Specify the main folder path
$folderPath = "G:\My Drive\_RealEstate\Active\Aftab\Rendering\Final Test Renders"

# Create a new HTML file
$htmlFilePath = "$folderPath\Gallery.html"
$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Photo Gallery - Kiavand and Draco Design and Construction</title>
<style>
    body { font-family: Arial, sans-serif; display: flex; }
    .nav { width: 200px; padding: 20px; background-color: #f4f4f4; height: 100vh; position: fixed; overflow-y: auto; }
    .nav a { display: block; margin: 10px 0; text-decoration: none; color: #000; font-weight: bold; }
    .content { margin-left: 220px; padding: 20px; }
    .header { text-align: center; }
    .header h1 { margin: 10px 0; }
    .header h2 { margin: 5px 0; color: #555; }
    .header h3 { margin: 5px 0; color: #777; }
    .folder { margin: 20px; }
    .folder img { margin: 5px; width: 150px; height: 150px; cursor: pointer; }
    .back-to-top { margin: 20px; text-align: center; }
</style>
</head>
<body>
<div class="nav">
    <h2></h2>
"@

# Add navigation links
foreach ($directory in Get-ChildItem -Path $folderPath -Directory) {
    $relativePath = $directory.FullName.Replace($folderPath, "").TrimStart("\")
    $htmlContent += "<a href='#$relativePath'>$($directory.Name)</a>"
}

$htmlContent += "</div><div class='content'><div class='header'>
    <h1>Kiavand and Draco Design and Construction</h1>
    <h2>Project: Aftab</h2>
    <h3>Dublex Unit - Floors 5 & 6</h3>
</div>"

foreach ($directory in Get-ChildItem -Path $folderPath -Directory) {
    $relativePath = $directory.FullName.Replace($folderPath, "").TrimStart("\")
    $htmlContent += "<div class='folder' id='$relativePath'><h2>$($directory.Name)</h2>"

    # Get the PNG files in the directory
    $pngFiles = Get-ChildItem -Path $directory.FullName -Filter *.png

    foreach ($pngFile in $pngFiles) {
        $pngRelativePath = $pngFile.FullName.Replace($folderPath, "").TrimStart("\")
        $htmlContent += "<a href='$pngRelativePath' target='_blank'><img src='$pngRelativePath' alt='$($pngFile.Name)'></a>"
    }

    # Add back-to-top link at the end of each folder section
    $htmlContent += "<div class='back-to-top'><a href='#top'>Back to Top</a></div>"

    $htmlContent += "</div>"
}

$htmlContent += "</div></body></html>"

# Save the HTML content to the file
$htmlContent | Out-File -FilePath $htmlFilePath -Encoding utf8

Write-Host "Gallery has been created at: $htmlFilePath"
