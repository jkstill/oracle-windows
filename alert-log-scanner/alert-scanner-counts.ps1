# Define the path to your alert log file
$alertLogPath = "alert_imop_05032023.log"

# Use Select-String to find all occurrences of TNS or ORA followed by digits
$errors = Select-String -Path $alertLogPath -Pattern '(TNS|ORA)-\d+' -AllMatches | 
    ForEach-Object { $_.Matches.Value } |
    Group-Object | 
    Sort-Object Name

# Process each unique error code with its count
foreach ($errorGroup in $errors) {
    $error = $errorGroup.Name
    $count = $errorGroup.Count
    $lowerError = $error.ToLower().Replace('-', ' ')
    Write-Host "==================="
    Write-Host "$lowerError - Occurrences: $count"
    # Replace the 'oerr' call with an equivalent command if available
    #Invoke-Expression "echo $lowerError"
}

