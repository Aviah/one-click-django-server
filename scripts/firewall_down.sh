iptables-restore < /etc/iptables.rules.accept.all
#ip6tables-restore < /etc/ip6tables.rules.accept.all
echo "=== iptables ==="
iptables -L -v
echo
echo "=== ip6tables ==="
#ip6tables -L -v