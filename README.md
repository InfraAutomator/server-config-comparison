<header>

# EC2 Automation Workflow

## Overview
This GitHub Actions workflow automates the process of running a PowerShell script on EC2 instances, collecting output, and uploading it to an S3 bucket. Below is a step-by-step explanation of each process.

## Explanation of Each Step

### 1. Checkout Repository
- Fetches the repository code from GitHub.
- Ensures that all scripts and configuration files are available for execution.

### 2. Set up AWS CLI Profile
- Configures AWS CLI without hardcoding secrets directly in the YAML file.
- Uses an AWS profile for authentication instead of GitHub Secrets.
- Creates necessary AWS configuration files to allow CLI operations.

### 3. Install AWS CLI & jq
- Installs AWS CLI to interact with AWS services.
- Installs `jq` for processing JSON output from AWS CLI commands.
- Ensures dependencies are available for automation.

### 4. Get EC2 Public IPs
- Reads instance IDs from `server_list.txt`.
- Uses AWS CLI to fetch the public IP addresses of the instances.
- Stores the retrieved IPs in an environment variable for later use.

### 5. Set up SSH Key for EC2 Access
- Retrieves the private SSH key stored in GitHub Secrets.
- Saves the key as a file and sets the correct permissions.
- Allows secure SSH connections to EC2 instances.

### 6. Execute PowerShell Script on EC2
- Establishes an SSH connection to each EC2 instance.
- Executes `script.ps1`, which runs a shell script (`command.sh`) on the instance.
- Ensures the script runs successfully and produces the expected output.

### 7. Upload Output to S3
- Retrieves the generated output files from the EC2 instances.
- Uses AWS CLI to upload the output files to a specified S3 bucket.
- Ensures that the output is stored safely for further processing or analysis.

## Next Steps
- Make sure your AWS credentials and secrets are configured correctly.
- Ensure EC2 instances allow SSH access from the GitHub Actions runner.
- Verify that your S3 bucket is properly configured to receive uploads.

This workflow helps automate EC2 operations, making it more efficient and secure.

</footer>
