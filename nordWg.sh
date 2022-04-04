IP=$(/sbin/ifconfig nordlynx | grep 'inet ' | tr -s ' ' | cut -d" " -f3)
LISTENPORT=$(sudo wg showconf nordlynx | grep 'ListenPort = .*')
PRIVATEKEY=$(sudo wg showconf nordlynx | grep 'PrivateKey = .*')
PUBLICKEY=$(sudo wg showconf nordlynx | grep 'PublicKey = .*')
ENDPOINT=$(sudo wg showconf nordlynx | grep 'Endpoint = .*')

echo "[INTERFACE]" >> nordlynx.conf
echo "Address = ${IP}" >> nordlynx.conf
echo "${PRIVATEKEY}" >> nordlynx.conf
echo "DNS = 103.86.96.100" >> nordlynx.conf
echo -e "[PEER]\n" >> nordlynx.conf
echo "${ENDPOINT}" >> nordlynx.conf
echo "${PUBLICKEY}" >> nordlynx.conf
echo "AllowedIPs = 0.0.0.0/0, ::/0" >> nordlynx.conf
echo "PersistentKeepalive = 25" >> nordlynx.conf

cat nordlynx.conf