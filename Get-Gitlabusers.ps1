#Creates an object for the API Token
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer PASTE TOKEN HERE")
$url = "YOUR GITLAB URL HERE"
$ExportFile = 'Local folder path here'

#invokes a GET method on the Gitlab API - Can be modified for different data
$response = Invoke-RestMethod '$url/api/v4/users?state=:active&per_page=300' -Method 'GET' -Headers $headers
$response | ConvertTo-Json -Depth 100

#Defines a table
$table = @()

#Creates table headers and adds each value from the api result to the table
foreach ($user in $response){
    $row = "" | Select-Object Name, State, Last_SignIn
    $row.Name = $user.name
    $row.State = $user.state
    $row.Last_SignIn = $user.last_activity_on
    $table += $row
}

#Exports the table to a CSV
$table | Export-Csv $ExportFile