@echo off
title Undo Lockdown Script (Restore Defaults)
echo Restoring Windows networking defaults. Requires Administrator.
echo.

:: ================================
:: 1. FIREWALL DEFAULTS
:: ================================
netsh advfirewall reset
netsh advfirewall set allprofiles state ON
netsh advfirewall set allprofiles firewallpolicy allowinbound,allowoutbound

:: Re-enable common rule groups
netsh advfirewall firewall set rule group="Remote Administration" new enable=Yes
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
netsh advfirewall firewall set rule group="Remote Assistance" new enable=Yes
netsh advfirewall firewall set rule group="Windows Remote Management" new enable=Yes

:: ================================
:: 2. REMOTE ACCESS SERVICE (RAS)
:: ================================
netsh ras set conf confstate=ENABLED
netsh ras set wanports device=* rasinonly=enabled ddinout=enabled ddoutonly=enabled
netsh ras set authmode mode=ANY
netsh ras ip set access mode=ALL
netsh ras ipv6 set access mode=ALL
netsh ras ipv6 set routeradvertise mode=ENABLED
netsh ras ip set addrreq mode=ALLOW

:: ================================
:: 3. INTERFACE SECURITY (IPv6)
:: ================================
netsh interface ipv6 set global randomizeidentifiers=disabled
netsh interface ipv6 set global privacy=disabled
netsh interface ipv6 set global routerdiscovery=enabled
netsh interface isatap set state enabled
netsh interface teredo set state default
netsh interface 6to4 set state default

:: ================================
:: 4. WINSOCK RESET (to defaults)
:: ================================
netsh winsock reset

:: ================================
:: 5. REMOTE SERVICES
:: ================================
:: Remote Desktop
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
:: Remote Assistance
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 1 /f

:: Remote Registry
sc config RemoteRegistry start= demand

:: Telnet
sc config tlntsvr start= demand

:: Internet Connection Sharing
sc config SharedAccess start= demand

:: Netlogon
sc config Netlogon start= demand

:: SMBv1 (re-enable if needed)
dism /online /norestart /enable-feature /featurename:SMB1Protocol

:: ================================
:: 6. REMOVE CUSTOM BLOCK RULES
:: ================================
netsh advfirewall firewall delete rule name="Block Inbound RDP 3389"
netsh advfirewall firewall delete rule name="Block Inbound VNC 5900-5909"
netsh advfirewall firewall delete rule name="Block Inbound Radmin 4899"
netsh advfirewall firewall delete rule name="Block Inbound ICMP Echo"
netsh advfirewall firewall delete rule name="Block Inbound ICMPv6 Echo"
netsh advfirewall firewall delete rule name="Allow Outbound Gaming - TCP"
netsh advfirewall firewall delete rule name="Allow Outbound Gaming - UDP"
netsh advfirewall firewall delete rule name="Allow Outbound DNS (UDP 53)"
netsh advfirewall firewall delete rule name="Allow Outbound DNS (TCP 53)"
netsh advfirewall firewall delete rule name="Allow Outbound HTTPS (TCP 443)"

:: ================================
:: 7. FINISH
:: ================================
echo Defaults restored. Please reboot to apply all changes.
pause
