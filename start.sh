#!/usr/bin/env sh

echo 'Starting up...'

# Error handling for iptables command
modprobe xt_mark

echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
#echo 'net.ipv6.conf.all.disable_policy = 1' | tee -a /etc/sysctl.conf

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

/app/tailscaled \
  --verbose=1 \
  --port 41641 \
  --state=mem: & # ephemeral-node mode (auto-remove)
#--tun=userspace-networking
#--socks5-server=localhost:1055

/app/tailscale up \
  --authkey="${TAILSCALE_AUTH_KEY}" \
  --advertise-tags=tag:exit \
  --advertise-exit-node # --hostname=yusoofs-"${FLY_REGION}" \

echo "Tailscale started. Let's go!"
sleep infinity
