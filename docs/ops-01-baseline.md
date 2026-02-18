# ops-01 Baseline  
## Ubuntu 24.04 LTS Platform Node

---

## 📅 Last Updated

2026-02-17

---

# 🖥 System Overview

- **Hostname:** ops-01
- **OS:** Ubuntu Server 24.04.3 LTS
- **Kernel:** 6.8.0-100-generic
- **IP Address:** 10.10.0.21/24
- **Gateway:** None (isolated subnet)
- **APT Proxy:** http://10.10.0.10:3142

---

# 👤 Administrative Model

- User: `jesse`
- Member of: `sudo`
- Root login: disabled via password
- SSH: key-based only

---

# 🔐 SSH Access

From workstation:

```
ssh ops-01
```

Identity file:

```
~/.ssh/id_ed25519
```

---

# 📦 Installed Base Packages

Installed during initial provisioning:

- curl
- wget
- git
- build-essential
- unzip
- ca-certificates
- gnupg
- software-properties-common

---

# 🌐 Network Model

- Static IP
- No default route
- Controlled egress via APT proxy
- No direct internet access

---

## Purpose of ops-01

Platform operations node responsible for:

- Automation
- Terraform execution
- Python scripting
- Infrastructure orchestration
- Internal service experimentation