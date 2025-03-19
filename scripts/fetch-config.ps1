# Load server list
$serverList = Get-Content "scripts/serverlist.txt"

# AWS Credentials & SSH Key
$sshUser = "ec2-user"   # Change if using another OS (ubuntu for Ubuntu)
$pemKey = "scripts/private_key.pem"  # Make sure your private key is in scripts/

# Check if ssh is installed
if (-Not (Get-Command ssh -ErrorAction SilentlyContinue)) {
    Write-Host "Installing OpenSSH..."
    Add-WindowsFeature -Name OpenSSH.Server
    Start-Service sshd
    Write-Host "OpenSSH installed successfully."
}

# Run command on each server
foreach ($server in $serverList) {
    Write-Host "Executing script on $server..."

    $outputFile = "output/$server-output.txt"
    
    # Run command.sh on EC2 machine
    ssh -i $pemKey -o StrictHostKeyChecking=no $sshUser@$server 'bash -s' < scripts/command.sh | Out-File -FilePath $outputFile
    
    Write-Host "Output saved to $outputFile"
}
