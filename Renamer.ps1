#requires -version 2.0

<#
.Synopsis
    Rename all apk files to format 'packageName.apk'
.Description
    Rename all apk files to format 'packageName.apk'
    Need aapt.exe in main folder
#>


#For silent mode, if not use you see all messages (include info and errors all native functions)
$ErrorActionPreference = 'silentlycontinue' 

$location = Get-Location

$currentPath = $location.Path

$files = Get-ChildItem $currentPath
$files = $files -match '([\w\W]\.apk)'

for ($i=0; $i -lt $files.Count; $i++)
{
    $fullAPKPath = $files[$i].FullName;

    $APKToolPath = $currentPath+"\aapt.exe"
    
    $aaptArg1 = "dump"
    $aaptArg2 = "badging"
  
    $data = & $APKToolPath $aaptArg1 $aaptArg2 $fullAPKPath

    $result = $data[0] -match 'name=''(.*?)'''

    $packageName = $Matches[1]

    Rename-Item $fullAPKPath $packageName".apk"

    Write-Output "Find: $packageName Full path: $fullAPKPath"
}


