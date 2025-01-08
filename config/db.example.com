$TTL 86400
@   IN  SOA ns.example.com. admin.example.com. (
        2024010101 ; Serial
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400 )    ; Minimum TTL

    IN  NS  ns.example.com.
ns  IN  A   192.168.1.10
www IN  A   192.168.1.20
