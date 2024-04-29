[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, HelpMessage = "Subscription ID")]
    [ValidateNotNullOrEmpty()]
    [String]$subscriptionId,
    [Parameter(Mandatory = $true, HelpMessage = "Location")]
    [ValidateNotNullOrEmpty()]
    [String]$location,
    [Parameter(Mandatory = $true, HelpMessage = "TemplateFile")]
    [ValidateNotNullOrEmpty()]
    [ValidateScript( { Test-Path $_ -PathType Leaf })]
    [String]$templateFile,
    [Parameter(Mandatory = $true, HelpMessage = "Template Parameters")]
    [ValidateNotNullOrEmpty()]
    [String]$templateParamFile,
    [Parameter(Mandatory = $true, HelpMessage = "SubscriptionName")]
    [ValidateNotNullOrEmpty()]
    [String]$subscriptionName,
    [Parameter(Mandatory = $true, HelpMessage = "Resource Group")]
    [ValidateNotNullOrEmpty()]
    [String]$resourceGroup
)

import-module Az.Resources -force
$deploymentParameters = @{
    "Name" = "$($location)-SQL"
    "Location" = $location
    "TemplateParameterFile" = $templateParamFile
    "TemplateFile" = $templateFile
    "ResourceGroupName" = $resourceGroup
}

if ((Get-AzContext).Subscription.Id -ne $subscriptionId){
    Write-Output "Azure Context not correct, switching to $subscriptionID context."
    Set-AzContext -SubscriptionId $subscriptionId
}

if (!(Test-Path $templateParamFile -PathType Leaf)){
    Write-Warning -Message "No Parameter file found for $subscriptionName - $location Skipping deployment."
} else {
    New-AzResourceGroupDeployment @deploymentParameters -verbose
}