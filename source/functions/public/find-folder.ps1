function find-folder {
    param (
        [string]$name,
        $proxy
    )
    $PossFolderIDs = ($proxy.SearchFolders($name)).folders.id
    foreach ($possfolderID in $PossFolderIDs){
        $FolderPath = $Null
        $TestFolderID = $possfolderID
        $ID = $possfolderID
        while ($TestFolderID -ne -1){
            $FolderPath = ($proxy.FolderGet($testfolderID)).Folder.name + "\" + $FolderPath
            $testFolderID = get-parentFolderID -folderID $testFolderID -proxy $proxy
        }
        $props = @{
            "FolderPath" = $FolderPath;
            "FolderID" = $ID
        }
        $myObj = New-Object -TypeName psobject -Property $props
        $myObj
    }
}