# Remote-Connections-Lockdown

# HackerScumBeGone.cmd
🔒 What this script does

-Turns off RAS entirely unless you explicitly need it.
-Closes WAN ports so no dial‑in connections can sneak through.
-Forces authentication — no bypass allowed.
-Blocks IPv6 spoofing vectors (router advertisements, fake IP requests).
-Locks down firewall to block inbound traffic by default.
-Disables Remote Desktop & SMBv1 — two common hijack targets.

# ExtraSecurityDoubleDownScript.cmd
🔒 What this script does

-No Remote Desktop / Remote Assistance → nobody can view/control your screen.
-No File Sharing / SMB / Printer Sharing → nobody can access your files.
-No Domain Controller / Shared Access Point → your PC won’t act as a server.
-Firewall locked down → inbound blocked, outbound allowed (so Roblox still works).
-RAS disabled → no dial‑in or VPN hijacking.
-Remote Registry & Telnet disabled → no hidden remote management.

# LastResortIHateMyLife.cmd 
🔒 What this does and why it’s safe

-Blocks inbound connections by default while keeping outbound open, using netsh advfirewall contexts and rule groups documented by Microsoft.
-Shuts down RAS dial-in paths, disables IPv6 router discovery and address requests, and enforces server-only roles—all via netsh ras and interface contexts.
-Disables legacy tunnels (6to4, Teredo, ISATAP) and NetBIOS behaviors that advertise your machine.
-Removes insecure Wi‑Fi profiles and resets Winsock to clear malicious hooks.
-Turns off Remote Desktop, Remote Assistance, Remote Registry, Telnet, ICS, and NetLogon; disables SMBv1 and file/printer sharing firewall groups.
-Keeps outbound DNS and HTTPS open, plus general outbound rules for gaming traffic so gaming services can connect.

🎮 Gaming Compatibility

-Outbound traffic (your PC → gaming servers) is still allowed.
-Inbound traffic (other PCs → your PC) is blocked unless you explicitly allow it.
-This means you can still play games online like Roblox and other online games, but nobody can use your PC as a remote access point.
-If any game component fails to connect, temporarily disable only the specific block rule that conflicts, but keep inbound default block in place.

# This will not block your own access to the internet you will still have normal
internet connection, it just blocks others from connecting to yours #

# RestoreAll.cmd
🔄 Rollback Script (Undo Lockdown)

✅ What this rollback does
-Resets firewall to default inbound/outbound policies.
-Re-enables RAS and WAN ports.
-Restores IPv6 discovery and tunneling features.
-Re-enables Remote Desktop, Remote Assistance, Remote Registry, Telnet, ICS, Netlogon, SMBv1.
-Deletes custom block/allow rules we added earlier.
-Resets Winsock to defaults again.

✅ How to use

1. Simply Download and Right Click to select Run As Administrator
(would typically advise not doing this as hackers run cmds to gain access to if you have been hacked,
it would be easy to edit these files and set the options to the opposite of what they are now to ALLOW
access, if you save, delete after running and be sure to Right Click and Empty Recycle Bin for added safety)

2. Simply copy and paste into your WINDOWS COMMAND PROMPT 
to bring up command prompt quickly press the windows key (usully between fn and alt on the
bottom left of your keyboard, it has a little icon of a window) and hold down the windows and R
key at the same time to open a search bar, type CMD and press Ctrl+Shift+Enter to launch as an Administrator,
highlight the text here and press Ctrl+C to copy, click inside CMD and press Ctrl+V to paste, hit Enter to run.

3. Or Copy the script into a text file (e.g., secure_network.cmd)
Right‑click → Run as Administrator.
I highly advise against this, since this is exactly how hacking happens, by having your files altered and you 
running malicious altered files on your pc, if you save it as a file, it leaves it open to being altered,
and if someone writes malicious code, or changes any of these values to the opposite of what i have, 
it will enable Remote Access to your PC, stay smart, stay safe, stay alert, and goodluck.

# References and Sources 

# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/netsh
# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/netsh-ras

The Windows links show and describes exacly what we are locking down, and the commands you can run for security,
most of which we are doing today.
This script is defensive only — it doesn’t interfere with other people’s computers, it just makes yours much harder to hijack
-Milamoo12340
