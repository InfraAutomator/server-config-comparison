# Define paths
$scriptRoot = "$PSScriptRoot"
$plink = "C:\Program Files\PuTTY\plink.exe"
$serverListFile = "$scriptRoot\scripts\serverlist.txt"
$commandFile = "$scriptRoot\scripts\command.sh"
$credentialsFile = "$scriptRoot\scripts\aws-credentials.txt"

# Read credentials from file
if (-not (Test-Path $credentialsFile)) {
    Write-Host "Error: aws-credentials.txt not found!"
    exit 1
}

$credentials = Get-Content $credentialsFile | ConvertFrom-Csv -Delimiter ","
$user = $credentials.Username
$pass = $credentials.Password

# Validate files
if (-not (Test-Path $serverListFile)) {
    Write-Host "Error: serverlist.txt not found!"
    exit 1
}

if (-not (Test-Path $commandFile)) {
    Write-Host "Error: command.sh not found!"
    exit 1
}

# Read server list
$servers = Get-Content $serverListFile

foreach ($server in $servers) {
    Write-Host "Running task on $server..."

    # Execute command using Plink and store output
    Write-Output y | & $plink -ssh $server -P 22 -l $user -pw $pass -m $commandFile | Out-File -FilePath "$scriptRoot\$server-output.txt"

    Write-Host "Output saved in: $scriptRoot\$server-output.txt"
}
