# Remote-Connections-Lockdown

🔒 What this script does

Turns off RAS entirely unless you explicitly need it.

Closes WAN ports so no dial‑in connections can sneak through.

Forces authentication — no bypass allowed.

Blocks IPv6 spoofing vectors (router advertisements, fake IP requests).

Locks down firewall to block inbound traffic by default.

Disables Remote Desktop & SMBv1 — two common hijack targets.

#This will not block your own access to the internet you will still have normal
internet connection, it just blocks others from connecting to yours#

✅ How to use

Simply copy and paste into your WINDOWS COMMAND PROMPT 
to bring up command prompt quickly press the windows key (usully between fn and alt on the
bottom left of your keyboard, it has a little icon of a window) and hold down the windows and R
key at the same time to open a search bar, type CMD and press Ctrl+Shift+Enter to launch as an Administrator,
highlight the text here and press Ctrl+C to copy, click inside CMD and press Ctrl+V to paste, hit Enter to run.

Or Copy the script into a text file (e.g., secure_network.cmd).
Right‑click → Run as Administrator.
I highly advise against this, since this is exactly how hacking happens, by having your files altered and you 
running malicious altered files on your pc, if you save it as a file, it leaves it open to being altered,
and if someone writes malicious code, or changes any of these values to the opposite of what i have, 
it will enable Remote Access to your PC, stay smart, stay safe, stay alert, and goodluck.

https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/netsh-ras
^ The above link shows and describes exacly what we are locking down, and the commands you can run for security,
most of which we are doing today.
This script is defensive only — it doesn’t interfere with other people’s computers, it just makes yours much harder to hijack
-Milamoo12340
