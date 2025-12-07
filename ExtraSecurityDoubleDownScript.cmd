:: Disable Remote Access Services

:: Disable Remote Access Service (RAS)
netsh ras set conf confstate=DISABLED
:: Restrict WAN ports (blocks dial-in hijacking attempts)
netsh ras set wanports device=* rasinonly=disabled ddinout=disabled ddoutonly=disabled
:: Require authentication for all dial-in clients
netsh ras set authmode mode=STANDARD

:: Block Remote Viewing / Remote Desktop

:: Disable Remote Desktop connections
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
:: Disable Remote Assistance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

:: Disable File Sharing & SMB

:: Disable SMBv1 (old vulnerable file sharing protocol)
dism /online /norestart /disable-feature /featurename:SMB1Protocol
:: Turn off file and printer sharing
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No

:: Prevent Domain / Shared Access Point Use

:: Block your PC from acting as a domain controller
sc config netlogon start= disabled
:: Disable network discovery (stops your PC being advertised)
netsh advfirewall firewall set rule group="Network Discovery" new enable=No
:: Disable ICS (Internet Connection Sharing)
sc config SharedAccess start= disabled

:: Firewall Hardening

:: Enable firewall for all profiles
netsh advfirewall set allprofiles state ON
:: Block inbound connections by default, allow outbound
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound
:: Disable remote management rules
netsh advfirewall firewall set rule group="Remote Administration" new enable=No

:: IPv4/IPv6 Security

:: Disable IPv6 router advertisements
netsh ras ipv6 set routeradvertise mode=DISABLED
:: Restrict IPv4/IPv6 negotiation to server-only
netsh ras ip set access mode=SERVERONLY
netsh ras ipv6 set access mode=SERVERONLY
:: Deny clients from requesting their own IP
netsh ras ip set addrreq mode=DENY

:: Disable Remote Services

:: Disable Remote Registry service
sc config RemoteRegistry start= disabled
:: Disable Telnet service
sc config tlntsvr start= disabled
