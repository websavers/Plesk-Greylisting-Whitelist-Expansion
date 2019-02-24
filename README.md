# Description
Plesk's greylisting functionality has a built-in pre-set whitelist, however it 
only whitelists a few public SMTP servers. This script pulls in a public whitelist 
and uses our/your own configuration in the custom_domains file, adding each to 
the Plesk greylisting whitelist

# Public whitelist source
The public whitelist comes from combined_rspamd_domains found here: https://whitelist.maven-group.org/

# Usage
You probably want to edit the first domain entry at the top of the custom_domains 
file such that websavers.ca is replaced with the domain your SMTP server(s) use. 
Then run: `./plesk_add_to_greylist_whitelist.sh`

Note: As long as the domain syntax doesn't change when running `plesk bin grey_listing`
then you can run this script repeatedly and Plesk will only add new records.
(As, for example, `*.websavers.ca` is different from `*websavers.ca`)

# Customization
You may wish to customize by adding your own entries to the whitelist. We analyze
our server mail logs for 451 errors like this: `grep "451 4.7.1" /var/log/maillog | more`
And use the results to find common legit mail servers to whitelist by adding to 
the custom_domains file. If you don't use that custom_domains file, our default
file will be retrieved with `wget` and used instead.

# Changelog
 2019-02-24
 - Added a bunch of newly detected mailers and moved CUSTOM_DOMAINS var to its own file: custom_domains
 2019-02-22
 - Initial version
 
# Requirements
- Plesk Onyx 17.x minimum (might work with Plesk 12.5. Untested.)
- curl
 
# Reference
- Docs: https://support.plesk.com/hc/en-us/articles/213394809-How-to-configure-Greylisting-
- Syntax Ref: https://support.plesk.com/hc/en-us/articles/214028429-Greylisting-defers-all-emails-from-Office-365-accounts
- Public Whitelist: https://whitelist.maven-group.org/
