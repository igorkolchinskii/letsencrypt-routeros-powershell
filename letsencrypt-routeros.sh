# powershell
# 
# Delete Certificate file if the file exist on RouterOS
$routeros /file remove $CERT.crt > /dev/null
$routeros /file remove $PRIVKEY.key /dev/null
$routeros /file remove $certchain.key /dev/null
# Upload Key to RouterOS
scp -q -P $ROUTEROS_SSH_PORT -i "$ROUTEROS_PRIVATE_KEY" "$KEY" "$ROUTEROS_USER"@"$ROUTEROS_HOST":"$DOMAIN.key"
sleep 2
# Import Key file
$routeros /certificate import file-name=$DOMAIN.key passphrase=\"\"
# Delete Certificate file after import
$routeros /file remove $DOMAIN.key

# Setup Certificate to SSTP Server
$routeros /interface sstp-server server set certificate=$DOMAIN.pem_0

exit 0
