function connect-winproxy {
    param (
        [switch]$test
    )
    #Two factor not enabled on Test, so can connect with all accounts using WinAuth. Also Windows Authentication installed and enabled on winauthwebservices in Test
    if ($test){
        if ($env:COMPUTERNAME -eq "<Test Server hostname") {
            $urlwin = "https://<Test Secret Server FQDN>/SecretServer/winauthwebservices/sswinauthwebservice.asmx?wsdl"
        }
        else {
            $urlwin = "https://<Secret Server FQDN/SecretServer/winauthwebservices/sswinauthwebservice.asmx?wsdl"
        }
    }
    else {
        $urlwin = "https://<Secret Server FADN>/secretserver/winauthwebservices/sswinauthwebservice.asmx?wsdl"
    }
    $proxy = New-WebServiceProxy -uri $urlwin -UseDefaultCredential
    $proxy
}