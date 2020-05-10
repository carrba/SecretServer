function invoke-SecretCheckin {
    param (
        [string]$SecretName,
        $proxy
    )
    $Secret = ($proxy.SearchSecrets($SecretName, $false, $false)).secretsummaries
    $proxy.Checkin($Secret.SecretID)
}