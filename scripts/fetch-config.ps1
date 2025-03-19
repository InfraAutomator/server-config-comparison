# Working Scrip##
# # Load server list
# $serverList = Get-Content "scripts/serverlist.txt"

# # AWS Credentials & SSH Key
# $sshUser = "ec2-user"   # Change if using another OS (ubuntu for Ubuntu)
# $pemKey = "scripts/private_key.pem"  # Make sure your private key is in scripts/

# # Check if ssh is installed
# if (-Not (Get-Command ssh -ErrorAction SilentlyContinue)) {
#     Write-Host "Installing OpenSSH..."
#     Add-WindowsFeature -Name OpenSSH.Server
#     Start-Service sshd
#     Write-Host "OpenSSH installed successfully."
# }

# # Run command on each server
# foreach ($server in $serverList) {
#     Write-Host "Executing script on $server..."

#     $outputFile = "output/$server-output.txt"
    
#     # Run command.sh on EC2 machine
#     Invoke-Expression "ssh -i $pemKey -o StrictHostKeyChecking=no $sshUser@$server 'bash -s' | Out-File -FilePath $outputFile" -InputObject (Get-Content "scripts/command.sh")
    
#     Write-Host "Output saved to $outputFile"
# }
# Working Scrip##



# Load server list
$serverList = Get-Content "scripts/serverlist.txt"

# AWS Credentials & SSH Key
$sshUser = "ec2-user"   # Change if using another OS (ubuntu for Ubuntu)
$pemKey = "scripts/private_key.pem"  # Make sure your private key is in scripts/
$commandScript = "scripts/command.sh"

# Check if SSH is installed
if (-Not (Get-Command ssh -ErrorAction SilentlyContinue)) {
    Write-Host "SSH is not installed. Please install OpenSSH manually."
    exit 1
}

# Create output directory if not exists
$outputDir = "output"
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Execute script on each server
foreach ($server in $serverList) {
    Write-Host "Executing script on $server..."
    
    $outputFile = "$outputDir/$server-output.txt"

    # SSH into EC2, run command.sh, and capture output
    $commandContent = Get-Content $commandScript
    Invoke-Expression "ssh -i $pemKey -o StrictHostKeyChecking=no $sshUser@$server `"$commandContent`" | Tee-Object -FilePath $outputFile"

    Write-Host "Output saved to $outputFile"
}

