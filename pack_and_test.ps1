#!/usr/bin/env pwsh

[CmdletBinding()]
param(
    [Parameter()]
    [string] $OutputDirectory = "TestProject"
)

$Configuration = "Release"
$TemplatePackageId = "BlazorStatic.Templates"
$ProjectTemplateShortName = "BlazorStaticMinimalBlog"

Write-Host "Packing the project..." -ForegroundColor Cyan
dotnet pack -c $Configuration

Write-Host "Uninstalling the old template '$TemplatePackageId' (if present)..." -ForegroundColor Cyan
dotnet new uninstall $TemplatePackageId
if ($LASTEXITCODE -ne 0) {
    Write-Host "Template '$TemplatePackageId' was not installed (or uninstall failed); continuing." -ForegroundColor DarkGray
}

$packedFolder = Join-Path $PSScriptRoot "bin/$Configuration"
$packagePath = Get-ChildItem -LiteralPath $packedFolder -File |
    Where-Object { $_.Name -like "$TemplatePackageId.*.nupkg" } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1 -ExpandProperty FullName

if ([string]::IsNullOrWhiteSpace($packagePath)) {
    throw "Template package not found in '$packedFolder'."
}
Write-Host "Installing the new template from '$packagePath'..." -ForegroundColor Cyan
dotnet new install --force $packagePath

# $outputPath = Join-Path $PSScriptRoot $OutputDirectory
# if (Test-Path -LiteralPath $outputPath) {
#     Write-Host "Removing the old '$OutputDirectory' directory..." -ForegroundColor Cyan
#     Remove-Item -LiteralPath $outputPath -Recurse -Force
# } else {
#     Write-Host "'$OutputDirectory' does not exist, skipping removal." -ForegroundColor DarkGray
# }

Write-Host "Creating a new project from the '$ProjectTemplateShortName' template..." -ForegroundColor Cyan
dotnet new $ProjectTemplateShortName -o $OutputDirectory --force

Write-Host "Building the generated project..." -ForegroundColor Cyan
Push-Location $outputPath
try {
    dotnet build -c $Configuration
} finally {
    Pop-Location
}
