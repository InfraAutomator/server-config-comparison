# Define parameters
$instances = Get-Content "serverlist.txt"
$command = "sh /home/ec2-user/command.sh"  # Remote script to run on EC2
$awsProfile = "default"  # AWS CLI profile to use
$region = "us-east-1"  # Change to your AWS region

# Loop through each instance
foreach ($instance in $instances) {
    Write-Host "Executing command on instance: $instance"
    
    $response = aws ssm send-command `
        --document-name "AWS-RunShellScript" `
        --targets "[{\"Key\":\"InstanceIds\",\"Values\":[\"$instance\"]}]" `
        --parameters "{\"commands\":[\"$command\"]}" `
        --region $region `
        --profile $awsProfile

    Write-Host "Command sent successfully to $instance!"
}
