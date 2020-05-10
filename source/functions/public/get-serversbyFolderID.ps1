function get-serversbyFolderID {
    param (
        [int]$folderId,
        [switch]$machine,
        [switch]$recurse,
        $proxy
    )
    $ht = @{}
    if ($machine){
        # Searchterm, folderID, include subfolders, include deleted, include Restricted. !! Needed to include restricted for Win Admin secrets !!
        if ($recurse){
            $Secrets = ($proxy.SearchSecretsByFolder("*", $folderID, $true, $false, $true)).secretsummaries
        }
        else {
            $Secrets = ($proxy.SearchSecretsByFolder("*", $folderID, $false, $false, $true)).secretsummaries
        }
        foreach ($secretID in $secrets){
            $IP = (($proxy.GetSecretLegacy($secretID.secretID)).secret.items | where-object fieldname -eq "Machine").value
            if (!($IP)){
                $IP = (($proxy.GetSecretLegacy($secretID.secretID)).secret.items | where-object fieldname -eq "URL").value
            }
            if (!($ht.containskey($IP))){
                $ht.Add($IP, $secretID.secretname)
            }
        }
        $ht
    }
    else {
        # Searchterm, folderID, include subfolders, include deleted, include Restricted. !! Needed to include restricted for mwilkes secrets !!
        $Secrets = ($proxy.SearchSecretsByFolder("*", $folderID, $false, $false, $true)).secretsummaries
        foreach ($secret in $Secrets){
            $server = ($secret.secretname -split("\\"))[0]
            if ($Server -eq "RLG"){
                # Check to see if $secret is a domain secret. In which case we need machine or URL value
                $Server = (($proxy.GetSecretLegacy($secret.secretID)).secret.items | where-object fieldname -eq "Machine").value
                if (!($Server)){
                    $Server = (($proxy.GetSecretLegacy($secret.secretID)).secret.items | where-object fieldname -eq "URL").value
                }
            }
            if ($server){
                if (!($ht.containskey($server))){
                    $ht.Add($server, 1)
                }
            }
        }
        $ht.keys
    }
}
