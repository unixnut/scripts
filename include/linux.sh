# TO-DO: include prefix bits if -p is specified

if_addr()
{
  ip addr show dev $1 scope global |
    awk '$1 == "inet" { print substr($2, 1, index($2, "/") - 1) }'
}

# Ignores link-local addresses
if_addr6()
{
  ip addr show dev $1 scope global |
    awk '$1 == "inet6" { print substr($2, 1, index($2, "/") - 1) }'
}
