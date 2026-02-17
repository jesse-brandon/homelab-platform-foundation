# Internal APT Caching Infrastructure

> Stable, containerized APT caching proxy for Proxmox and lab VMs.

---


## 📌 Objective

Provide a consistent internal APT endpoint for:

- Proxmox host updates  
- Debian/Ubuntu lab VMs  
- Reduced redundant downloads  
- Improved reliability  
- Enterprise-style package management simulation  

---

## 🧠 Design Decisions

### Docker Instead of WSL

Initial implementation attempts used WSL2. However, WSL2 introduces:

- Dynamic internal IP addressing
- NAT complexity
- Service lifecycle dependency on WSL state
- Additional port forwarding requirements

Docker Desktop was selected because it:

- Publishes ports directly to the Windows host IP
- Provides stable service binding
- Survives reboots cleanly
- Behaves like real infrastructure

---

### HTTP Proxy Model

APT clients are configured to use a proxy rather than rewriting repository URLs.

This keeps client configuration simple and consistent.

Example proxy configuration:

```bash
Acquire::http::Proxy "http://10.10.0.10:3142";
```

Benefits of this approach:

- No modification of `sources.list`
- Easy rollback
- Centralized control
- Clear separation of infrastructure and client configuration

---

## 🚀 Implementation

### 1️⃣ Configure Windows Ethernet

Set the Ethernet adapter with a static configuration:

```
IP Address: 10.10.0.10
Subnet Mask: 255.255.255.0
Gateway: (blank)
```

Allow inbound TCP port 3142:

```powershell
New-NetFirewallRule -DisplayName "APT Cacher 3142" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 3142
```

---

### 2️⃣ Deploy apt-cacher-ng Container

Run the container:

```powershell
docker run -d --name apt-cache -p 3142:3142 sameersbn/apt-cacher-ng
```

Verify it is running:

```powershell
docker ps
```

Test locally:

```
http://localhost:3142
```

Test from Proxmox:

```bash
curl http://10.10.0.10:3142
```

---

### 3️⃣ Configure Proxmox to Use Proxy

Create the proxy configuration file:

```bash
echo 'Acquire::http::Proxy "http://10.10.0.10:3142";' > /etc/apt/apt.conf.d/01proxy
```

Run update:

```bash
apt update
```

---

### 4️⃣ Remove Enterprise Repositories (Non-Subscription Setup)

To avoid HTTPS proxy errors:

```bash
rm /etc/apt/sources.list.d/pve-enterprise.sources
rm /etc/apt/sources.list.d/ceph.sources
```

Then:

```bash
apt update
```

---

## ✅ Validation

Confirm successful deployment with the following checks:

- `curl http://10.10.0.10:3142` returns the Apt-Cacher NG usage page
- `apt update` completes without proxy errors
- Package downloads succeed
- Subsequent updates retrieve cached packages

To verify cache activity, access:

```
http://10.10.0.10:3142/acng-report.html
```

This provides statistics and cache usage details.

---

## 🔧 Operational Commands

Start container:

```powershell
docker start apt-cache
```

Stop container:

```powershell
docker stop apt-cache
```

Restart container:

```powershell
docker restart apt-cache
```

Check container status:

```powershell
docker ps
```

---

## 📈 Future Improvements

Potential enhancements to evolve this infrastructure:

- Internal DNS entry (e.g., `apt.lab.local`)
- Reverse proxy with TLS termination
- Container restart policy (`--restart unless-stopped`)
- Metrics collection and monitoring
- Expansion to additional package ecosystems
- Infrastructure-as-Code deployment

---

## 🏁 Outcome

This implementation demonstrates:

- Network troubleshooting and subnet isolation
- Containerized infrastructure services
- Stable internal service exposure
- Controlled package management strategy
- Reproducible lab architecture design

This component forms part of a broader homelab platform foundation supporting:

- Data engineering experimentation  
- Infrastructure automation  
- Platform architecture development  
- Enterprise-style operational practices  

---