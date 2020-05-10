function get-secrettemplate {
    param (
        [string]$name,
        $proxy
    )
    $templates = $proxy.getsecrettemplates().secretTemplates
    if ($name){
        $mytemplate = $templates | where-object name -eq $name
        $mytemplate
    }
    else {
        $templates
    }
}