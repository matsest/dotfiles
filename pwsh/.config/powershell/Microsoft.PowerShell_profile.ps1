# Set prompt
oh-my-posh init pwsh --config ~/.config/oh-my-posh/powerline.omp.json | Invoke-Expression

# Initialize PS Readline
Import-module PSReadline
Import-module Az.Tools.Predictor
Import-module CompletionPredictor
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryandPlugin

# Adding alias for vim style quit
function exitPS { Invoke-Command -ScriptBlock { exit } }
Set-alias -Name ':q' -Value exitPS

# Windows specific
if ($PSVersionTable.Platform -eq "Win32NT") {
  # Alias for recursive grep in PowerShell
  # Usage: ps-rgrep <pattern> [-i] [<path>] [-v] [-e] [-w] [-x]
  function ps-rgrep {
    param(
      [Parameter(Position = 0, Mandatory = $true)] [string] $Pattern,
      [Parameter(Mandatory = $false, HelpMessage = "Ignore case")] [switch] $i,
      [Parameter(Mandatory = $false, HelpMessage = "Invert match")] [switch] $v,
      [Parameter(Mandatory = $false, HelpMessage = "Use regex pattern")] [switch] $e,
      [Parameter(Mandatory = $false, HelpMessage = "Match only whole words")] [switch] $w,
      [Parameter(Mandatory = $false, HelpMessage = "Match only whole lines")] [switch] $x,
      [Alias("f")][Parameter(Mandatory = $false)] [string] $Path = $(Get-Location)
    )

    $caseSensitive = (!$i) ? $true : $false # Mimic linux behavior - default should be case sensitive if not -i is given
    $invertMatch = $v ? $true : $false
    $isSimple = $e ? $false : $true

    # match only whole words
    if ($w) {
      $Pattern = '\b{0}\b' -f $Pattern
      $isSimple = $false
    }

    # match only whole lines excluding newline characters
    if ($x) {
      $Pattern = '^{0}$' -f $Pattern
      $isSimple = $false
    }

    Get-ChildItem -Path $Path -Recurse | Select-String -Pattern $Pattern -CaseSensitive:$caseSensitive -NotMatch:$invertMatch -SimpleMatch:$isSimple
  }
}
