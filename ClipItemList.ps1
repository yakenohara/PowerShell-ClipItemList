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

$str_elements = New-Object System.Collections.Generic.List[System.String]

$str_parentPathName = Split-Path -Parent $Args[0]
$str_elements.Add($styleStr_DirStart + $str_parentPathName + $styleStr_DirEnd)

# NOTE
# ($Args.count -eq 1 ) の場合に `$Args | Sort-Object` すると、意図しない動作になるため、
# その場合は `Sort-Object` しない
if ($Args.count -eq 1) { # 引数の数が 1 つの場合

    $str_fileName = Split-Path -Leaf $Args[0] # ファイル/フォルダ名を取得
    $str_elements.Add($styleStr_EndOfList + $str_fileName)

} else { # 引数の数が 2 つ以上ある場合
    
    $str_sortedArgs = $Args | Sort-Object
   
    # 最後の要素の一つ前までループ
    for ($idx = 0 ; $idx -lt ($str_sortedArgs.count - 1) ; $idx++){
        $str_fileName = Split-Path -Leaf $str_sortedArgs[$idx] # ファイル/フォルダ名を取得
        $str_elements.Add($styleStr_MiddleOfList + $str_fileName)
    }

    # 最後の要素
    $str_fileName = Split-Path -Leaf $str_sortedArgs[$str_sortedArgs.count - 1]
    $str_elements.Add($styleStr_EndOfList + $str_fileName)
}

# クリップボードに保存
Set-Clipboard ($str_elements -Join "`r`n")
