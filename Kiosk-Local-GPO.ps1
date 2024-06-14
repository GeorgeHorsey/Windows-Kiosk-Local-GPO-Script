# Powershell scrpt to lock down a kiosk windows PC. 


# Import the GroupPolicy module
Import-Module GroupPolicy

# Define the path to the local Group Policy Object
$GPOPath = "LocalGPO"  # Check if this is the correct path: C:\WINDOWS\PolicyDefinitions

# Create or open the local GPO
$GPO = Get-GPO -Name $GPOPath -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOPath
}

# Define the path to the policy setting
$PolicyPath = "Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment"

# Define the policy name and the user or group to add
$PolicyName = "SeInteractiveLogonRight"  # Allow log on locally
$UserOrGroup = "DOMAIN\Username"

# Set the policy value
Set-GPRegistryValue -Name $GPO.DisplayName -Key "$PolicyPath" -ValueName $PolicyName -Value $UserOrGroup

# Refresh the policy to apply it
gpupdate /force

Write-Output "Local GPO policy set successfully."
