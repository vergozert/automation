Install-Module AzureAutomationAuthoringToolkit

$connection = Get-AutomationConnection -Name AzureRunAsConnection
$loginresults=Login-AzureRmAccount -ServicePrincipal -Tenant $connection.TenantID `
-ApplicationId $connection.ApplicationID -CertificateThumbprint $connection.CertificateThumbprint
$context = Get-AzureRmContext
$SubscriptionId = $context.Subscription
$cache = $context.TokenCache
$cacheItem = $cache.ReadItems()
$AccessToken=($cacheItem | Where-Object { $_.Resource -eq “https://management.core.windows.net/" })[0].AccessToken
Write-Output -InputObject @{AccessToken = $AccessToken; SubscriptionId = $SubscriptionId }