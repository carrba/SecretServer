function get-secret {
    param (
        [string]$SecretName,
        [int]$secretID,
        $proxy
    )
    if (!($secretid -ge 1)){
        $secretID = get-secretid -SecretName $secretname -proxy $proxy
    }
    $SecretLegacy = $proxy.Getsecretlegacy($secretID).secret
    $secretLegacy
}