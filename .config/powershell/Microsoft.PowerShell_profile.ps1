$homePath = (Resolve-Path ~).Path

function SubSwitch {
    $sub = ((Get-AzSubscription | Sort-Object -Property Name).Name | fzf --border)
    Select-AzSubscription -SubscriptionName $sub
}

function AzSubSwitch {
    $sub = ((az account list -o json | ConvertFrom-Json | Sort-Object -Property Name).Name | fzf --border)
    az account set --name $sub; az account show -o json | ConvertFrom-Json
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

function GetAllKeyVaultSecrets {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $vaultName
    )
    Get-AzKeyVaultSecret -VaultName $vaultName | ForEach-Object { Write-Host ("Secret: {0,-40} {1}" -f $_.Name, (Get-AzKeyVaultSecret -VaultName $vaultName -Name $_.Name -AsPlainText)) }
}

function GetKeyVaultSecret {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $vaultName
    )
    $secretName = (Get-AzKeyVaultSecret -VaultName $vaultName | Sort-Object -Property Name).Name | fzf --border
    $secretValue = Get-AzKeyVaultSecret -VaultName $vaultName -Name $secretName -AsPlainText
    return $secretValue
}

function SwitchBranch {
  git switch (git branch | fzf --border).Trim()
}

function gdf {
    Get-Date -f FileDateTime | Set-Clipboard
}

New-Alias -Name swb -Value SwitchBranch
New-Alias -Name tf -Value terraform
New-Alias -Name ll -Value Get-ChildItem
New-Alias -Name tm -Value terramate

Invoke-Expression (&starship init powershell)

