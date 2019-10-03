$Arr = @()

$MajorHash = [ordered]@{
    Major = 4,3
}

$MajorObj = new-object psobject -property $MajorHash

$MinorHash = [ordered]@{
    Major = 3,4
}
$MinorObj = new-object psobject -property $MinorHash

$Arr += $MajorObj
$Arr += $MinorObj

$arr | convertto-json