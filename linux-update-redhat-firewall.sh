# A simple bash script to update the Redhat linux host to only accept remote connections from a specific IP.
# Note that this script uses the zone 'trusted'. The trusted zone should be further restricted. Here is an example.
# firewall-cmd --zone=trusted --add-source=<IP of desired host or hosts in CIDR>
# firewall-cmd --zone=trusted --add-service=ssh
# firewall-cmd --zone=trusted --list-all
# The result of the example above is that only the specified IP (or IPs) are allowed to connect to the host using ssh.
(current1=$(firewall-cmd --zone=trusted --list-sources)
firewall-cmd --zone=trusted --remove-source=$current1)
(vpn1=$(ping -c1 fqdn | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
firewall-cmd --zone=trusted --add-source=$vpn1
firewall-cmd --runtime-to-permanent)
