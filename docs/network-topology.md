# Network-Topology
## 🏗 Architecture

```mermaid
flowchart TD
    Internet --> WiFi
    WiFi --> Windows["Windows Workstation\nWiFi + Ethernet 10.10.0.10"]
    Windows --> Docker["Docker: apt-cacher-ng\nPort 3142"]
    Docker --> Switch
    Switch --> Proxmox["Proxmox Host\n10.10.0.13"]
    Proxmox --> VMs["Lab VMs\n10.10.0.0/24"]
```

---

## 🌐 Network Design

| Component        | IP Address      | Notes                      |
|------------------|----------------|----------------------------|
| Windows Ethernet | 10.10.0.10/24  | Static IP, no gateway      |
| Proxmox Host     | 10.10.0.13/24  | Uses APT proxy             |
| APT Proxy        | 10.10.0.10:3142| Docker container           |
| Lab Subnet       | 10.10.0.0/24   | Isolated internal network  |

---
