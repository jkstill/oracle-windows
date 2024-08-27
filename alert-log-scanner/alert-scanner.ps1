
# from linux
#grep -hoE '(TNS|ORA)-[[:digit:]]+'  alert-log-test/alert_cdb1.log \
#| sort -u \
#| perl -p -e '$_=lc($_); s/-/ /'  \
#| xargs -I {} bash -c "echo '==================='; echo {} ; oerr {}"
	
# Define the path to your alert log file
$alertLogPath = "alert_imop.log"

# Use Select-String to find all occurrences of TNS or ORA followed by digits
$errors = Select-String -Path $alertLogPath -Pattern '(TNS|ORA)-\d+' -AllMatches | 
    ForEach-Object { $_.Matches.Value } |
    Sort-Object -Unique

# Process each unique error code
foreach ($error in $errors) {
    $lowerError = $error.ToLower().Replace('-', ' ')
    Write-Host "==================="
    Write-Host $lowerError
    # Replace the 'oerr' call with an equivalent command if available
    # If 'oerr' is a custom command, you might need to port that functionality to PowerShell
    # Example: Call a custom function to handle the error description
    #Invoke-Expression "oerr $lowerError"
    #Invoke-Expression "echo $lowerError"
}

