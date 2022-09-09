# ps-update-fw-rule.ps1
# A simple example PowerShell script to modify a firewall rule from dynamic DNS.
# Requires: No dependencies
# Recommended: After testing, schedule PowerShell with parameters -NoProfile -File Full-path-to-script

# This name of the blocking firewall rule (set for TCP Port 3389) must be created manually first
$fwrule = "External DDNS to HTTPS"

# Increase -Hour 1 to find more than last 1 hours, can also use more than -Day 1
$externalIP1 = (Test-Connection -TargetName fqdn -Count 1 -IPv4 | Select-Object -ExpandProperty Address).IPAddressToString

# Update the firewall rule
Set-NetFirewallRule -DisplayName $fwrule -RemoteAddress $externalIP1
