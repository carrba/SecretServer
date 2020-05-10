function get-checkedout {
    param (
        $proxy,
        $token,
        $searchterm,
        [switch]$noEerror
    )
    $loc = $proxy.SearchSecrets($token, $searchterm, $false, $false)
    foreach ($l in $loc.SecretSummaries){
        if (($proxy.getcheckoutstatus($token, $l.secretid)).IsCheckedOut){
            $sec = $proxy.getsecret($token, $l.secretID, $true,@())
            If ($noError){
                If ($sec.errors -notmatch "There may be an issue with changing the password.") {
                $props = @{
                    "SecretName" = $l.SecretName;
                    "SecretID" = $l.SecretID;
                    "Errors" = $sec.errors
                }
                $myobj = new-object -typeName PSObject -property $props
                $myOb
                }
            }
            elseIf ($sec.errors -match "There may be an issue with changing the password.") {

                $props = @{
                    "SecretName" = $l.SecretName;
                    "SecretID" = $l.SecretID;
                    "Errors" = $sec.errors
                }
                $myobj = new-object -typeName PSObject -property $props
                $myObj
            }
        }
    }
}