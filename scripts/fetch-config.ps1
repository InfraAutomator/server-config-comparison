# Define paths
$plink = 'C:\Users\m.vikrant.tagunde\PuTTY\plink.exe'
$remoteserver = Get-Content "C:\Users\m.vikrant.tagunde\PuTTY\serverlist.txt"
$user = Read-Host "Username"
$pass = Read-Host "Password"
$cmd = "C:\Users\m.vikrant.tagunde\PuTTY\command.sh"

# Loop through each server and execute the command
foreach ($srv in $remoteserver) {
    Write-Host "Running task on $srv..."
    
    # Execute the remote script using Plink and save output
    Write-Output y | & $plink -ssh $srv -P 22 -l $user -pw $pass -m $cmd | Out-File -FilePath ".\$srv.txt"
    
    Write-Host "Configuration details saved in $srv.txt"
}