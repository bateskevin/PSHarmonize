Function Clear-MidiMemory {
    
    $MemoryHash = @{}

        $MemoryHash.0 = $null
        $MemoryHash.1 = $null
        $MemoryHash.2 = $null
        $MemoryHash.3 = $null
        $MemoryHash.4 = $null
        $MemoryHash.5 = $null
        $MemoryHash.6 = $null
        $MemoryHash.7 = $null
        $MemoryHash.8 = $null
        $MemoryHash.9 = $null
        $MemoryHash.10 = $null
        $MemoryHash.11 = $null
        $MemoryHash.12 = $null
        $MemoryHash.13 = $null
        $MemoryHash.14 = $null
        $MemoryHash.15 = $null
        $MemoryHash.16 = $null


    $MemoryObj = New-Object psobject -Property $MemoryHash

    $MemoryObj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\Memory.json



}