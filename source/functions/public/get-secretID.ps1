function get-secretid {
    param (
        [string]$SecretName,
        $proxy
    )
    $Secret = ($proxy.SearchSecrets($SecretName, $false, $true)).secretsummaries
    $secret.secretid
}