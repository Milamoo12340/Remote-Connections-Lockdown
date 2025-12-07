@echo off
title PC Lockdown for Security and Game Services
echo Starting lockdown. Requires Administrator. Press Ctrl+C to abort.
echo.

:: ================================
:: 1. FIREWALL HARDENING
:: ================================
netsh advfirewall set allprofiles state ON
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound

netsh advfirewall firewall set rule group="Remote Administration" new enable=No
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No
netsh advfirewall firewall set rule group="Network Discovery" new enable=No
netsh advfirewall firewall set rule group="Remote Assistance" new enable=No
netsh advfirewall firewall set rule group="Windows Remote Management" new enable=No

netsh advfirewall firewall add rule name="Block Inbound ICMP Echo" protocol=icmpv4:8,any dir=in action=block
netsh advfirewall firewall add rule name="Block Inbound ICMPv6 Echo" protocol=icmpv6:128,any dir=in action=block

netsh advfirewall firewall add rule name="Allow Outbound DNS (UDP 53)" dir=out action=allow protocol=UDP remoteport=53
netsh advfirewall firewall add rule name="Allow Outbound DNS (TCP 53)" dir=out action=allow protocol=TCP remoteport=53
netsh advfirewall firewall add rule name="Allow Outbound HTTPS (TCP 443)" dir=out action=allow protocol=TCP remoteport=443

:: ================================
:: 2. REMOTE ACCESS SERVICE (RAS)
:: ================================
netsh ras set conf confstate=DISABLED
netsh ras set wanports device=* rasinonly=disabled ddinout=disabled ddoutonly=disabled
netsh ras set authmode mode=STANDARD
netsh ras ip set access mode=SERVERONLY
netsh ras ipv6 set access mode=SERVERONLY
netsh ras ipv6 set routeradvertise mode=DISABLED
netsh ras ip set addrreq mode=DENY

:: ================================
:: 3. INTERFACE SECURITY
:: ================================
netsh interface ipv6 set global randomizeidentifiers=enabled
netsh interface ipv6 set global privacy=enabled
netsh interface ipv6 set global routerdiscovery=disabled
netsh interface isatap set state disabled
netsh interface teredo set state disabled
netsh interface 6to4 set state disabled

:: ================================
:: 4. WINSOCK RESET
:: ================================
netsh winsock reset

:: ================================
:: 5. DISABLE REMOTE SERVICES
:: ================================
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

sc config RemoteRegistry start= disabled
sc stop RemoteRegistry

sc config tlntsvr start= disabled
sc stop tlntsvr

sc config SharedAccess start= disabled
sc stop SharedAccess

sc config Netlogon start= disabled
sc stop Netlogon

dism /online /norestart /disable-feature /featurename:SMB1Protocol
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=No

:: ================================
:: 6. BLOCK COMMON REMOTE CONTROL PORTS
:: ================================
netsh advfirewall firewall add rule name="Block Inbound RDP 3389" dir=in action=block protocol=TCP localport=3389
netsh advfirewall firewall add rule name="Block Inbound VNC 5900-5909" dir=in action=block protocol=TCP localport=5900-5909
netsh advfirewall firewall add rule name="Block Inbound Radmin 4899" dir=in action=block protocol=TCP localport=4899

:: ================================
:: 7. KEEP GAMING OUTBOUND WORKING
:: ================================
netsh advfirewall firewall add rule name="Allow Outbound Gaming - TCP" dir=out action=allow protocol=TCP remoteport=1-65535
netsh advfirewall firewall add rule name="Allow Outbound Gaming - UDP" dir=out action=allow protocol=UDP remoteport=1-65535

echo Lockdown complete. Please reboot to apply all changes.
pause

