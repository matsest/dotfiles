# Initialize PS Readline
Import-Module Az.Tools.Predictor
Import-Module CompletionPredictor
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryandPlugin

# Adding alias for vim style quit
function exitPS { Invoke-Command -ScriptBlock { exit } }
Set-alias -Name ':q' -Value exitPS
