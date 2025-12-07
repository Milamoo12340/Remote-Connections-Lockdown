:: ================================
:: Secure RAS and Network Settings
:: ================================

:: 1. Disable Remote Access Service (RAS) if you don’t use VPN/dial-in
netsh ras set conf confstate=DISABLED

:: 2. Restrict WAN ports (blocks dial-in hijacking attempts enter the names of any hidden network adapters or WAN ports revealed when you click view/view hidden devices in device manager that arent your normal wifi connection)
netsh ras set wanports device=* rasinonly=disabled ddinout=disabled ddoutonly=disabled

:: 3. Require authentication for all dial-in clients
netsh ras set authmode mode=STANDARD

:: 4. Disable IPv6 router advertisements (prevents rogue IPv6 hijack attempts)
netsh ras ipv6 set routeradvertise mode=DISABLED

:: 5. Restrict IPv4/IPv6 negotiation to server-only
netsh ras ip set access mode=SERVERONLY
netsh ras ipv6 set access mode=SERVERONLY

:: 6. Deny clients from requesting their own IP (blocks rogue address injection)
netsh ras ip set addrreq mode=DENY

:: 7. Enable firewall for all profiles (extra layer of protection)
netsh advfirewall set allprofiles state ON

:: 8. Block inbound connections by default (only allow trusted apps)
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound

:: 9. Disable remote desktop if not needed
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f

:: 10. Disable SMBv1 (old file sharing protocol often exploited)
dism /online /norestart /disable-feature /featurename:SMB1Protocol
