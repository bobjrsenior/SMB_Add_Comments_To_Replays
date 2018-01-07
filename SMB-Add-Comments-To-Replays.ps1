 param (
    [string]$SMBToolLoc = "",
    [int]$Padding = 3,
    [Parameter(Mandatory=$true)][string]$ReplayList
 )

 <#
.SYNOPSIS
    Inserts comments into SMB1 .gci replay files
.DESCRIPTION
    gci replay files names and there corresponding comments should be in a
    corresponding text file. Each line should be in the format "GCI_FILE=COMMENT".
    Empty lines are ignores. Lines without a comment are ignored
.SYNTAX
    SMB-Add-Comments-To-Replays.ps1 [[-SMBToolLoc] <string>] [[-Padding] <int>] [-ReplayList] <string>
.Required
    -Replay-List <string> Path to the text file containing gci file names and comments
.Optional
    -Padding <string> How many digits to zero pad the floor numbers in comments Default is 3.
    -SMBToolLoc <string> Where the smb tool is. Default is current directory
.NOTES
    File Name      : SMB-Add-Comments-To-Replays.ps1
    Author         : bobjrsenior (bobjrsenior@gmail.com)
.LINK
    Script hosted at:
    https://github.com/bobjrsenior/SMB_Add_Comments_To_Replays
.EXAMPLE
    .\SMB-Add-Comments-To-Replays.ps1 -ReplayList replayList.txt
.EXAMPLE
    .\SMB-Add-Comments-To-Replays.ps1 -ReplayList replayList.txt -Padding 3 -SMBToolLoc "C:\smb-build-replay.exe"
#>

 $currentDir = (Resolve-Path .\).Path + "\"
 if($SMBToolLoc -eq "")
 {
    $SMBToolLoc = $currentDir + "smb-build-replay.exe"
 }

 $ReplayList = $currentDir + $ReplayList


 # Command line parameters
 $inputTypeSwitch = "-i"
 $inputType = "gci"
 $outputTypeSwitch = "-o"
 $outputType = "gci"
 $inFileSwitch = "--in-file"
 $outFileSwitch = "--out-file"
 $paddingSwitch = "--pad-floor-number"
 $commentSwitch = "-c"


 foreach($line in Get-Content $ReplayList)
 {
    # Split by '=' and call smb-tool appropriately
    $lineSplit = $line.split("=")
    
    if($lineSplit.length -eq 2)
    {
        "Adding comment to: " + $lineSplit[0]
        $gciPath = $currentDir + $lineSplit[0]
        & $SMBToolLoc $inputTypeSwitch $inputType $outputTypeSwitch $outputType $inFileSwitch $gciPath $outFileSwitch $gciPath $paddingSwitch $padding $commentSwitch $lineSplit[1]
    }
 }