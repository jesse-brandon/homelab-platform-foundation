# 🔐 GitHub SSH Configuration (Personal & Work Separation)

## Overview

This workstation is configured to support multiple GitHub identities using separate SSH keys and host aliases.

This prevents:

* Account cross-contamination
* Enterprise SSO takeover issues
* Work/personal credential conflicts
* Token management via HTTPS

The setup supports:

* **Personal GitHub** → `jesse-brandon`
* **Work GitHub (future)** → separate identity

---

# 🧱 Architecture

| Purpose              | SSH Host Alias    | SSH Key               |
| -------------------- | ----------------- | --------------------- |
| Personal GitHub      | `github-personal` | `id_ed25519_personal` |
| Work GitHub (future) | `github-work`     | `id_ed25519_work`     |

---

# 🔑 SSH Key Generation (PowerShell)

## Generate Personal Key

```powershell
ssh-keygen -t ed25519 -C "jessebrandon052@gmail.com" -f $env:USERPROFILE\.ssh\id_ed25519_personal
```

This creates:

```
~/.ssh/id_ed25519_personal
~/.ssh/id_ed25519_personal.pub
```

Add the `.pub` file contents to:

GitHub → Settings → SSH and GPG Keys

---

# ⚙️ SSH Config File

File:

```
~/.ssh/config
```

Configuration:

```
# Personal GitHub
Host github-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_personal
    IdentitiesOnly yes

# Work GitHub (future use)
Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_work
    IdentitiesOnly yes
```

---

# 🔄 Switching a Repository to SSH

Convert an HTTPS remote to SSH:

```powershell
git remote set-url origin git@github-personal:jesse-brandon/<repo-name>.git
```

Verify:

```powershell
git remote -v
```

Expected:

```
git@github-personal:jesse-brandon/<repo-name>.git
```

---

# 🧠 PowerShell SSH Agent Setup

To avoid entering the passphrase on every push:

## Enable SSH Agent Service (One-Time Setup)

```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
```

## Add Key to Agent

```powershell
ssh-add $env:USERPROFILE\.ssh\id_ed25519_personal
```

The key will now persist across reboots.

---

# 🧪 Testing SSH Authentication

Test personal connection:

```powershell
ssh -T github-personal
```

Expected:

```
Hi jesse-brandon! You've successfully authenticated...
```

---

# 🏢 Future Work Account Setup

When a work GitHub account is created:

```powershell
ssh-keygen -t ed25519 -C "work@company.com" -f $env:USERPROFILE\.ssh\id_ed25519_work
```

Add that key to the work GitHub account.

Use remotes formatted as:

```
git@github-work:company/repo.git
```

No config changes required — architecture already supports it.

---

# ✅ Best Practices

* Never attach work emails to personal GitHub
* Never reuse SSH keys between identities
* Always use passphrases
* Use SSH over HTTPS for multi-account setups
* Keep identities logically and cryptographically separated

---

# 🎯 Result

This setup ensures:

* Clean personal branding
* Enterprise-proof identity separation
* Professional multi-account Git hygiene
* Scalable configuration for future employment

---

If you'd like, we can also:

* Add a short architectural diagram
* Add a section on signed commits (GPG or SSH signing)
* Integrate this into your workstation baseline documentation

This is exactly the kind of operational maturity recruiters appreciate when reviewing infrastructure repos.
