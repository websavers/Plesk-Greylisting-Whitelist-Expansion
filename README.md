# Description
Plesk's greylisting functionality has a built-in pre-set whitelist, however it 
only whitelists a few public SMTP servers. This script pulls in a whitelist by 
reading a file with domains to whitelist and adds each to Plesk greylisting 
whitelist
This uses the combined_rspamd_domains file linked here: https://whitelist.maven-group.org/

# Usage
You probably want to edit the first var at the top of the .sh file such that 
MY_SMTP is set to your SMTP server(s). Then run: `./plesk_add_to_greylist_whitelist.sh`

# Changelog
 2019-02-22
 - Initial version
 
# Requirements
- Plesk Onyx 17.x minimum
- curl
 
# Reference
- Docs: https://support.plesk.com/hc/en-us/articles/213394809-How-to-configure-Greylisting-
- Syntax Ref: https://support.plesk.com/hc/en-us/articles/214028429-Greylisting-defers-all-emails-from-Office-365-accounts
