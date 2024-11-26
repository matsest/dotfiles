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
if($PSVersionTable.Platform -eq "Win32NT"){
  function rgrep {
    param(
      [Parameter(Position = 0, Mandatory = $true)] [string] $Pattern,
      [Parameter(Mandatory = $false)] [string] $Path = $(Get-Location)
    )
    Get-ChildItem -Path $Path -Recurse | Select-String -Pattern $Pattern
  }
}
