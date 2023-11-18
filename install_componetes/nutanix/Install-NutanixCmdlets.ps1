$ModuleNames = @('Nutanix.Cli', 'Nutanix.Prism.PS.Cmds', 'Nutanix.Prism.Common')
  
# Zipped file directory separator
$ZippedDirectorySeparator = "C:\Users\t818008511\Documents\GitHub\Inventario\install_componetes\nutanix\"
$PathSeparator = [IO.Path]::PathSeparator
  
# Sync current location with the environment variable
[Environment]::CurrentDirectory = Get-Location
# Add required type
Add-Type -Assembly 'System.IO.Compression.FileSystem'
  
# Choose the first path from PSModulePath
$dest = (($env:PSModulePath).Split($PathSeparator) | Select-Object -first 1)
  
  
$zip = [IO.Compression.ZipFile]::OpenRead("NutanixCmdlets.zip")
  
$zip.Entries | ForEach-Object  {
  if (-Not $_.FullName.EndsWith($ZippedDirectorySeparator)) {
    $PathItems = $_.FullName.Split($ZippedDirectorySeparator)
    if ($PathItems.Length -gt 2 -and $ModuleNames.Contains($PathItems[1])) {
      $Target = $dest
      # Remove the first path 'NutanixCmdlet'
      $TargetPathItems = $PathItems[1..($PathItems.Length-1)]
      $TargetPathItems | Foreach-Object {
        $Target = [IO.Path]::Combine($Target, $_)
      }
      $DirectoryName = [IO.Path]::GetDirectoryName($Target)
      $null = New-Item -ItemType Directory -Force -Path $DirectoryName
      [IO.Compression.ZipFileExtensions]::ExtractToFile($_, $Target)
    }
  }
}
  
Write-Host "Successfully Installed in $dest"