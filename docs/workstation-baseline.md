# Workstation Baseline  
## Homelab Platform Foundation

> Authoritative record of development and infrastructure tooling installed on the Windows workstation.

---

# 🧰 Git Configuration

## Purpose

Git provides:

- Version control for lab documentation
- Infrastructure tracking
- Change history for platform decisions
- Integration with GitHub repositories

Git is intentionally installed system-wide (not relying on GitHub Desktop's bundled version).

---

## 📦 Installation

- **Version:** 2.53.0.windows.1  
- **Source:** https://git-scm.com/download/win  
- **Install Mode:** System-wide (CLI available in PowerShell and Windows Terminal)

Installer selections:

- Use bundled OpenSSH
- Use Windows default console
- Default branch name: `main`
- Pull behavior: `rebase`
- Credential helper: Git Credential Manager
- Enable symbolic links (if available)

---

## 👤 Global Identity

Configured for professional documentation tracking:

```powershell
git config --global user.name "Jesse Brandon"
git config --global user.email "jesse.brandon@hotmail.com"
```

---

## ⚙ Global Configuration

Current global configuration:

```powershell
git config --global --list
```

Expected baseline:

```
user.name=Jesse Brandon
user.email=jesse.brandon@hotmail.com
pull.rebase=true
core.editor=code --wait
```

---

## 🧠 Pull Strategy

Configured for linear history:

```powershell
git config --global pull.rebase true
```

Rationale:

- Prevents unnecessary merge commits
- Keeps infrastructure history clean
- Produces readable `git log`

---

## 📝 Default Editor

VS Code configured as default editor:

```powershell
git config --global core.editor "code --wait"
```

---

## 🔐 Credential Management

Uses:

- Git Credential Manager (bundled with Git for Windows)

Provides secure authentication for GitHub operations.

---

## 📌 Operational Notes

- Git is available system-wide in PowerShell and Windows Terminal.
- GitHub Desktop may be used for visual workflow, but CLI is authoritative.
- Global configuration is intentional and reproducible.
- Any changes to global Git config should be documented here.

---

## 📅 Last Reviewed

2026-02-17


# 🖥 VS Code Configuration

## Purpose

VS Code serves as the primary development and infrastructure authoring environment for:

- Markdown documentation
- Git workflow
- Container management
- Remote SSH administration
- Infrastructure-as-Code (Terraform)
- Python automation

---

## 📦 Installed Extensions (Baseline)

```powershell
code --list-extensions
```

### Current Extension Set

```
eamodio.gitlens
hashicorp.terraform
ms-azuretools.vscode-containers
ms-azuretools.vscode-docker
ms-python.debugpy
ms-python.python
ms-python.vscode-pylance
ms-python.vscode-python-envs
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode.remote-explorer
yzhang.markdown-all-in-one
```

---

## 🧠 Extension Philosophy

Only extensions directly supporting platform engineering are installed.

### Categories

**Version Control**
- GitLens

**Container Management**
- Docker
- Containers

**Remote Administration**
- Remote SSH
- Remote Explorer

**Infrastructure as Code**
- Terraform

**Python Platform Support**
- Python
- Pylance
- Debugpy
- Python Environments

**Documentation**
- Markdown All in One

---

## 📝 Operational Notes

- Extensions are intentionally minimal.
- No theme or cosmetic extensions included.
- VS Code serves as the authoritative documentation editor.
- Remote SSH enables direct Proxmox and VM editing without local file duplication.

---

## 📅 Last Reviewed

2026-02-17

---

# 🖥 Windows Terminal Configuration

## Purpose

Windows Terminal serves as the primary command-line interface for:

- Git operations
- Docker management
- SSH access to Proxmox and lab VMs
- General administrative tasks

It replaces legacy Command Prompt usage and avoids dependency on WSL shells.

---

## Default Profile

Default shell:

```
PowerShell
```

Rationale:

- Native Windows administration
- Full Git CLI support
- Docker CLI support
- SSH client availability
- Consistent environment across sessions

---

## Verified Tool Availability

From Windows Terminal:

```powershell
git --version
docker --version
ssh -V
```

### Recorded Versions

- **Git:** 2.53.0.windows.1  
- **Docker Desktop Engine:** 29.1.3  
- **OpenSSH (Windows):** OpenSSH_for_Windows_9.5p2  
- **SSL Library:** LibreSSL 3.8.2  

---


All core tooling must be accessible directly within PowerShell.

---

## Configuration Philosophy

- No cosmetic themes required
- No prompt customizers installed
- No WSL default shell
- Keep environment predictable and minimal
- Infrastructure first, aesthetics second

---

## Operational Notes

- Windows Terminal is the authoritative shell environment.
- WSL is not used for infrastructure services.
- All core platform tools are available system-wide.
- If PowerShell profile changes are made, they should be documented.

---

## 📅 Last Reviewed

2026-02-17

---

## 🔐 SSH Client Configuration

SSH alias configured for Proxmox host.

### SSH Config File

Location:

```
C:\Users\<username>\.ssh\config
```

### Alias Definition

```
Host carbon
    HostName 10.10.0.13
    User root
    IdentityFile ~/.ssh/id_ed25519
```

### Usage

```powershell
ssh carbon
```

### Purpose

- Simplifies administrative access
- Standardizes connection method
- Explicitly defines identity file
- Prevents accidental key mismatch

---

SSH authentication is key-based only.
Password login is disabled on the Proxmox host.