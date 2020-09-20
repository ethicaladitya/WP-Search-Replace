#!/bin/bash
echo "Please enter url you wish to replace"
read sourceurl
echo "Please enter the destination URL"
read destinationurl
echo "Want email addresses changed too? y/n"
read emails

wp search-replace $sourceurl $destinationurl --skip-themes --skip-plugins
wp search-replace http://$destinationurl https://$destinationurl --skip-themes --skip-plugins
# Check if Emails also needs to be replaced
if [[ n==emails ]]; then
    wp search-replace @$sourceurl @$destinationurl --skip-themes --skip-plugins
fi

#Flush Object Cache
wp cache flush