function get-parentFolderID {
    param (
        [int]$folderID,
        $proxy
    )
    $myVal = $proxy.FolderGet($folderID).folder.parentfolderid
    $myVal
}