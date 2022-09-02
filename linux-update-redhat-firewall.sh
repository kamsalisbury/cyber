# A simple bash script to update the Redhat linux host to only accept remote connections from a specific IP.
(current1=$(firewall-cmd --zone=trusted --list-sources)
firewall-cmd --zone=trusted --remove-source=$current1)
(vpn1=$(ping -c1 fqdn | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
firewall-cmd --zone=trusted --add-source=$vpn1
firewall-cmd --runtime-to-permanent)
