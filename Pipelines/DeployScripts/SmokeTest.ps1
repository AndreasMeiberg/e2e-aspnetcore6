param
(
    [Parameter(Mandatory=$True,Position=1)]
    [string]$url
)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

try
{
    Write-Host "Testing URL: $url"
    $response = Invoke-WebRequest $url -UseBasicParsing
    Write-Host "Web request succeeded with HTTP" $response.StatusCode "("$response.StatusDescription")"
}
catch
{
    $errorMessage = "Web request FAILED with error: $_"
    Write-Host $errorMessage
    Write-Host "##vso[task.logissue type=error;]$errorMessage"
    throw $errorMessage
}

# Let's check the response and look for something meaningful
$titleCheck = $response.Content.Contains("ASP.NET Core sample</title>")

if ($titleCheck -eq $true)
{
    Write-Host "Title check: OK."
}
else
{
    $errorMessage = 'Title check FAILED.'
    Write-Host $errorMessage
    Write-Host "##vso[task.logissue type=error;]$errorMessage"
    throw $errorMessage
}