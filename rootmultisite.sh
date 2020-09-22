#!/bin/bash
echo "Please enter url you wish to replace"
read sourceurl
echo "Please enter the destination URL"
read destinationurl
echo "Want email addresses changed too? y/n"
read emails

su -s /bin/bash -c "wp search-replace $sourceurl $destinationurl --network --url=$sourceurl" www-data | tee -ai search-replace.log
su -s /bin/bash -c "wp search-replace http://$destinationurl https://$destinationurl --network --url=$destinationurl" www-data | tee -ai search-replace.log
# Check if Emails also needs to be replaced
if [[ n==emails ]]; then
    su -s /bin/bash -c "wp search-replace @$sourceurl @$destinationurl --skip-themes --network --url=$destinationurl" www-data | tee -ai search-replace.log
fi

#Flush Object Cache
su -s /bin/bash -c "wp cache flush --skip-themes --skip-plugins" www-data
