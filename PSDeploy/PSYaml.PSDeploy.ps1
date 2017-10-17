# Specify Module Name
$ModuleName = "PSYaml"

$InstallPath = $env:PSModulePath.split(";") | Where-Object {$_ -match "My Documents" -or $_ -match "Documents"}

# Need to go from ModuleVersion = '1.0' to just 1.0
$Version = (Get-Content (Join-Path $ModuleName "$ModuleName.psd1") | Where-Object {$_ -match "^ModuleVersion.*"})
$Version = $Version.Split("=")[1].Trim()
$Version = $Version.Replace("'","")

Deploy "Install $ModuleName to $(Join-Path (Join-Path $InstallPath $ModuleName) $Version)" {
    By Filesystem {
        FromSource $ModuleName
        To (Join-Path (Join-Path $InstallPath $ModuleName) $Version)
        WithOptions @{
            Mirror = $True
        }
    }
}
