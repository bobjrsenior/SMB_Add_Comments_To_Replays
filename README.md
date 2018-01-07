# SMB_Add_Comments_To_Replays
A tool to Insert comments into SMB1 .gci replay files.

.gci replay files names and there corresponding comments should be in a corresponding text file. Each line should be in the format "GCI_FILE=COMMENT". Empty lines are ignored. Lines without a comment are ignored

# Usage

    SMB-Add-Comments-To-Replays.ps1 [[-SMBToolLoc] <string>] [[-Padding] <int>] [-ReplayList] <string>
    
## Required

    -Replay-List <string> Path to the text file containing gci file names and comments
    
## Optional

    -Padding <string> How many digits to zero pad the floor numbers in comments Default is 3.
    -SMBToolLoc <string> Where the smb tool is. Default is current directory
    
# Examples

    .\SMB-Add-Comments-To-Replays.ps1 -ReplayList replayList.txt
    .\SMB-Add-Comments-To-Replays.ps1 -ReplayList replayList.txt -Padding 3 -SMBToolLoc "C:\smb-build-replay.exe"
