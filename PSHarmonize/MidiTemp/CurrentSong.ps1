    Import-Module PeteBrown.PowerShellMidi.dll -Force

    $Device = (Get-MidiOutputDeviceInformation | Where-Object {$_.name -eq "Midi"}).Id

    $Port = Get-MidiOutputPort -Id $Device    
    Send-MidiNoteOnMessage -Note 72 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 72 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 72 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 72 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 81 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 81 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 81 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 81 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 857.142857142857
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 74 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 74 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 74 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 74 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 72 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 857.142857142857
Send-MidiNoteOffMessage -Note 72 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 74 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 857.142857142857
Send-MidiNoteOffMessage -Note 74 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 74 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 857.142857142857
Send-MidiNoteOffMessage -Note 74 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 72 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 72 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 72 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 72 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 81 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 81 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 81 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 81 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 79 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 857.142857142857
Send-MidiNoteOffMessage -Note 79 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 77 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 77 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 76 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 76 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 74 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 74 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 74 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 428.571428571429
Send-MidiNoteOffMessage -Note 74 -Velocity 10 -Channel 0 -Port $Port
    Send-MidiNoteOnMessage -Note 72 -Velocity 100 -Channel 0 -Port $Port
Start-Sleep -Milliseconds 857.142857142857
Send-MidiNoteOffMessage -Note 72 -Velocity 10 -Channel 0 -Port $Port
