iptables-restore < /etc/iptables.rules.firewall
#ip6tables-restore < /etc/ip6tables.rules.firewall
echo "=== iptables ==="
iptables -L -v
echo
echo "=== ip6tables ==="
#ip6tables -L -v