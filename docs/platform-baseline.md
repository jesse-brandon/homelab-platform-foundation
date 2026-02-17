# Platform Baseline  
## Homelab Platform Foundation

> Authoritative record of hardware, software, and network state for the foundational lab environment.

---

## 📅 Last Updated

2026-02-17

---

# 🖥 Proxmox Host

## Node Name

carbon


---

## 🔩 Current Hardware

- **CPU:** Intel i5-6400  
- **RAM:** 16 GB  
- **Primary Storage:** 256GB SSD (Proxmox OS)  
- **Network Interface:** 1x Gigabit Ethernet  

---

## 💾 Current Storage Layout

| Purpose      | Device      | Notes              |
|--------------|------------|--------------------|
| Proxmox OS   | 256GB SSD  | Local installation |
| VM Storage   | Local SSD  | Default storage    |

---

## 🧩 Expansion Hardware (Not Yet Installed)

Additional hardware available for future scaling:

- **RAM:** +16 GB (total potential: 32 GB)
- **Storage:**
  - 256GB SATA SSD
  - 2 × 1TB Dell SATA HDD

Planned use cases (future):

- Dedicated VM storage pool
- ZFS experimentation
- Separate datastore for data workloads
- Backup or cold storage tier

---

## 🌐 Network Configuration

| Setting         | Value        |
|----------------|-------------|
| IP Address     | 10.10.0.13  |
| Subnet Mask    | 255.255.255.0 |
| Gateway        | 10.10.0.1   |
| Lab Subnet     | 10.10.0.0/24 |

APT proxy configured:

```
http://10.10.0.10:3142
```

---

## 🧠 Software Versions

Run the following to verify current state:

```bash
pveversion
uname -a
```

### Proxmox Environment

- **Proxmox VE Version:** 9.1.1  
- **pve-manager Build:** 42db4a6cf33dac83  
- **Running Kernel:** 6.17.2-1-pve  
- **Kernel Build Date:** 2025-10-21  
- **Architecture:** x86_64  

Command Output Reference:

```bash
pve-manager/9.1.1/42db4a6cf33dac83 (running kernel: 6.17.2-1-pve)

Linux carbon 6.17.2-1-pve #1 SMP PREEMPT_DYNAMIC PMX 6.17.2-1 (2025-10-21T11:55Z) x86_64 GNU/Linux
```

---

# 🖥 Windows Infrastructure Host

## 🔩 Hardware

- **CPU:**  Processor	12th Gen Intel(R) Core(TM) i9-12900K, 3200 Mhz, 16 Core(s), 24 Logical Processor(s)
- **RAM:**  64 GB
- **Primary Network:** WiFi (Internet)  
- **Internal Network:** Ethernet (10.10.0.10/24)  

---

## 🧠 Software

- **Windows Version:**  Windows 11 Version 25H2 (OS Build 26200.7840)
- **Docker Desktop Version:**  Server: Docker Desktop 4.56.0 (214940)
- **APT Cache Container Image:**  sameersbn/apt-cacher-ng
- **Published Port:** 3142

---

# 🏗 Foundational Services

| Service            | Host IP      | Port | Purpose                 |
|-------------------|-------------|------|--------------------------|
| APT Cacher NG     | 10.10.0.10  | 3142 | Internal package cache   |

---

# 🔎 Operational Notes

- Windows Ethernet is static with no gateway.
- Docker container configured with `--restart unless-stopped`.
- Proxmox uses HTTP proxy model for APT.
- Enterprise repositories removed (non-subscription setup).

---

# 🧭 Change Log

Document significant infrastructure changes here.

Example:

```
2026-02-17 — Initial platform baseline documented.
```

---

## 📌 Purpose of This Document

This file provides:

- Version traceability  
- Rebuild reference  
- Audit baseline  
- Drift detection support  

It should be updated whenever:

- Proxmox is upgraded  
- Kernel version changes  
- Network topology changes  
- Core infrastructure services are modified  