# <License>------------------------------------------------------------

#  Copyright (c) 2022 Shinnosuke Yakenohara

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

# -----------------------------------------------------------</License>


# <Settings>----------------------------------------------------------------
$styleStr_DirStart = '"'
$styleStr_DirEnd = '"'
$styleStr_MiddleOfList = '┣'
$styleStr_EndOfList = '┗'
# ---------------------------------------------------------------</Settings>

# Argument check
if ($Args.count -lt 1){
    Write-Error ("[error] Argment(s) not specified.")
    return
}

$convertedLines = New-Object System.Collections.Generic.List[System.String]

$fInfos = $Args | Sort-Object

$str_parentPathName = Split-Path -Parent $Args[0]
$convertedLines.Add($styleStr_DirStart + $str_parentPathName + $styleStr_DirEnd)

for ($idx = 0 ; $idx -lt ($fInfos.count - 1) ; $idx++){
    $str_fileName = Split-Path -Leaf $fInfos[$idx]
    $convertedLines.Add($styleStr_MiddleOfList + $str_fileName)
}

$str_fileName = Split-Path -Leaf $fInfos[$fInfos.count - 1]
$convertedLines.Add($styleStr_EndOfList + $str_fileName)

Set-Clipboard ($convertedLines -Join "`r`n")
