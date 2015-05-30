# Flush all rules
ip6tables -F

# Default policy
ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP

# localhost
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT

# ssh
ip6tables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# http
ip6tables -A INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

# https
ip6tables -A INPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# apt-get
ip6tables -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED  -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

# DNS
ip6tables -A INPUT -p udp --sport 53 -m state --state ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

# SMTP
ip6tables -A INPUT -p tcp --sport 25 -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 25 -j ACCEPT
ip6tables -A INPUT -p tcp --sport 587 -j ACCEPT
ip6tables -A OUTPUT -p tcp --dport 587 -j ACCEPT

# NTP
ip6tables -A INPUT -p udp --sport 123 -m state --state ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -p udp --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT

# Ping
ip6tables -A INPUT -p icmpv6 --icmpv6-type echo-request -j ACCEPT
ip6tables -A OUTPUT -p icmpv6 --icmpv6-type echo-reply -j ACCEPT
