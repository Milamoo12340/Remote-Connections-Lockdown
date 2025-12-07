:: Firewall lockdown
netsh advfirewall set allprofiles state ON
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound
netsh advfirewall firewall set rule group="Remote Administration" new enable=No
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No
netsh advfirewall firewall set rule group="Network Discovery" new enable=No

:: Disable Remote Access Service
netsh ras set conf confstate=DISABLED
netsh ras set wanports device=* rasinonly=disabled ddinout=disabled ddoutonly=disabled

:: IPv6 security
netsh interface ipv6 set privacy state=enabled
netsh interface ipv6 set global randomizeidentifiers=enabled
netsh interface ipv6 set global routerdiscovery=disabled

:: Reset Winsock (clears hijacked network hooks)
netsh winsock reset
