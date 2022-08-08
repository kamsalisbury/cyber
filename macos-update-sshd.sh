# A simple bash script to update macOS sshd to only allow specific remote login from specific IP.

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
