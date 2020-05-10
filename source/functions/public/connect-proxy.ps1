function connect-proxy {
    $urlprod = 'https://<SecretServer FQDN>/webservices/sswebservice.asmx'
    $proxy = New-WebServiceProxy -uri $urlprod -UseDefaultCredential
    $proxy
}