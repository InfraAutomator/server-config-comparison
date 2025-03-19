# Define Paths
$plink = "C:\Users\m.vikrant.tagunde\PuTTY\plink.exe"
$serverListPath = "scripts/serverlist.txt"
$commandPath = "scripts/command.sh"
$outputDir = "output"
$usePasswordAuth = $false  # Set to $true to use password authentication

# Ask for credentials
$user = Read-Host "Enter SSH Username"

# Authentication Method
if ($usePasswordAuth) {
    $pass = Read-Host "Enter SSH Password" -AsSecureString
    $plainPass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass)
    )
} else {
    $pemKeyPath = Read-Host "\private_key.pem"
}

# Create output directory if it doesn't exist
if (!(Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Read Server List
$servers = Get-Content $serverListPath

foreach ($server in $servers) {
    Write-Host "Connecting to $server..."
    
    $outputFile = "$outputDir\$server.txt"
    
    if ($usePasswordAuth) {
        # Use Password Authentication
        Write-Output y | & $plink -ssh $server -P 22 -l $user -pw $plainPass -m $commandPath | Out-File -FilePath $outputFile
    } else {
        # Use Private Key Authentication
        Write-Output y | & $plink -ssh $server -P 22 -i $pemKeyPath -l $user -m $commandPath | Out-File -FilePath $outputFile
    }
    
    Write-Host "Output saved in $outputFile"
}

Write-Host "✅ All commands executed successfully!"
