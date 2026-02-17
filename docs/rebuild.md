# Rebuild Guide  
## Homelab Platform Foundation

This document provides the minimum required steps to rebuild the foundational infrastructure components of the homelab from scratch.

---

# 🏗 Target State

After completion, the environment should provide:

- Stable internal APT caching endpoint: `10.10.0.10:3142`
- Proxmox host configured to use internal proxy
- Successful `apt update` without enterprise repository errors

---

# 1️⃣ Windows Infrastructure Host

## Configure Static Ethernet

Set the Windows Ethernet adapter:

```
IP Address: 10.10.0.10
Subnet Mask: 255.255.255.0
Gateway: (blank)
DNS: (blank)
```

This interface serves as the internal infrastructure network.

---

## Install & Start Docker Desktop

Ensure Docker Desktop is installed and running.

Verify:

```powershell
docker ps
```

---

## Allow Firewall Port

```powershell
New-NetFirewallRule -DisplayName "APT Cacher 3142" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 3142
```

---

# 2️⃣ Deploy APT Caching Service

Run apt-cacher-ng container:

```powershell
docker run -d --name apt-cache -p 3142:3142 sameersbn/apt-cacher-ng --restart unless-stopped
```

Verify container is running:

```powershell
docker ps
```

Test locally:

```
http://localhost:3142
```

---

# 3️⃣ Proxmox Configuration

## Confirm Network

Proxmox host should be configured:

```
IP: 10.10.0.13
Subnet: 255.255.255.0
Gateway: 10.10.0.1 (or lab gateway)
```

---

## Configure APT Proxy

Create proxy configuration file:

```bash
echo 'Acquire::http::Proxy "http://10.10.0.10:3142";' > /etc/apt/apt.conf.d/01proxy
```

---

## Remove Enterprise Repositories (Non-Subscription)

```bash
rm /etc/apt/sources.list.d/pve-enterprise.sources
rm /etc/apt/sources.list.d/ceph.sources
```

---

## Update Package Lists

```bash
apt update
```

Expected result:

- No proxy errors
- No enterprise repository errors
- Successful retrieval of package lists

---

# 4️⃣ Validation

From Proxmox:

```bash
curl http://10.10.0.10:3142
apt update
```

Access statistics page:

```
http://10.10.0.10:3142/acng-report.html
```

---

# 🔄 Rebuild Checklist

- [ ] Windows Ethernet static IP configured
- [ ] Docker Desktop running
- [ ] apt-cache container running
- [ ] Firewall rule created
- [ ] Proxmox proxy configured
- [ ] Enterprise repositories removed
- [ ] `apt update` successful

---

# 🧠 Notes

- Docker must remain running for APT proxy availability.
- Windows Ethernet IP must remain static.
- Port 3142 must remain open on Windows firewall.
- If Proxmox cannot reach the proxy, verify Layer 2 connectivity and firewall rules.