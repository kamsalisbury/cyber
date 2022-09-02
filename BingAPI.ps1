# Reference https://www.bing.com/webmasters/url-submission-api

# Access then decrypt key file
$KeyFile = Read-Host -Prompt 'Input full or relative path to key file ex. BingAPI.key' # Remember, saving your keys in clear text is always bad, so secure them.
$EncryptedKey = Get-Content $KeyFile | ConvertTo-SecureString
$DecryptedKey = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($EncryptedStorageKey))

# Gather variables
$Domain = Read-Host -Prompt 'Input the main domain url ex. https://domain.tld'
$URI = Read-Host -Prompt 'Input a URL to submit ex. https://domain.tld/page.html'

# Build payload
$BingAPIendpoint = 'https://ssl.bing.com/webmaster/api.svc/json/SubmitUrl?apikey=' + $DecryptedKey
$Body = @{
    siteUrl = "$Domain"
    url = "$URI"
}

# Fire
Invoke-RestMethod -Method Post -Uri "$BingAPIendpoint" -Body (ConvertTo-Json $Body) -ContentType 'application/json'
