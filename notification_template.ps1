$baseUrl = "https://your-subdomain.zendesk.com/api/v2"
$username = "your-email@example.com"
$password = "your-password"
$encodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($username + ":" + $password))

$headers = @{
    Authorization = "Basic $encodedCredentials"
    "Content-Type" = "application/json"
}

$body = @{
    ticket = @{
        subject = "Example ticket"
        comment = @{
            body = "This is an example ticket created via PowerShell"
        }
        requester = @{
            name = "John Doe"
            email = "john.doe@example.com"
        }
        priority = "normal"
        tags = @("PRTG")
    }
} | ConvertTo-Json

$uri = "$baseUrl/tickets.json"

$response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body

if ($response) {
    Write-Host "Ticket created successfully. Ticket ID:" $response.ticket.id
}
else {
    Write-Host "Failed to create ticket."
}
