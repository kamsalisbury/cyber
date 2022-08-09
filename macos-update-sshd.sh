# A simple bash script to update macOS sshd to only allow specific remote login from specific IP.

## macOS ssh remote user setup guide:
## macOS System Settings, Users & Groups, Create a non-Admin User,. Assign a long, complex password. Right-click on that non-Admin User, assign a new Home Directory location on a non-Primary macOS disk (such as a USB drive).
## macOS System Settings, Sharing, Enable Remote Login, Allow access for: "Only these users", specify the non-Admin login.
## macOS Security & Privacy, Firewall Tab, Ensure Firewall is ON, Firewall Options, Ensure "Remote Login (SSH)" is added.
## macOS Finder, locate the disk containing the new non-Admin login's Home Directory (the Home Directory must be a sub-directory of the disk), Right-click the disk, Select Get Info. Ensure the non-Admin login is added to the disk with Read & Write privilege. Use the elipses to "Apply to enclosed items".
## macOS Terminal, sudo su, su non-Admin login, cd, ssh-keygen -t dsa, touch ~/.ssh/authorized_keys
## Add the external host public key to the file ~/.ssh/authorized_keys
## vi /etc/ssh/sshd_config.d/110-macos-sshd.conf, Add configuration options "PermitRootLogin no" and "AllowUsers non-AdminLogin@ip.ip.ip.ip"
## Best Practice: If port forwarding through a firewall to the macOS host, utilize LAN firewall rule scheduling to minimize when the port forwarding is active.
## After completing the above, test access from the remote host using password.
## After validating access is what is intended, add these lines to the /etc/ssh/sshd_config.d/110-macos-sshd.conf file "PasswordAuthentication no" and "PubkeyAuthentication yes"
## Test key login from remote host.
## In scenarios without static IPs, consider implementing the script below in cron.
## Result, the macOS system has a non-Admin priviledge login that is allowed to access the macos sshd Remote Login using only key authentication to be able to use its home directory on an isolated non-operating system disk, from a specific IP address.

# Assign remote host IP into a variable
trusted1=$(ping -c1 fqdn | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')

# If current sshd conf is up to date, exit. Else update the conf file.
# /etc/ssh/sshd_config.d/110-macos-sshd.conf
if [ ! grep -q $trusted1 "/etc/ssh/sshd_config.d/110-macos-sshd.conf" ]; then
  echo "PermitRootLogin no\nAllowUsers login@$trusted1" > /etc/ssh/sshd_config.d/110-macos-sshd.conf
  # Restart sshd
  launchctl unload /System/Library/LaunchDaemons/ssh.plist
  launchctl load -w /System/Library/LaunchDaemons/ssh.plist
fi
