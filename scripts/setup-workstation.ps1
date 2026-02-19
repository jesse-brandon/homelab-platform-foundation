Write-Host "Starting Workstation Setup..." -ForegroundColor Cyan

# ---------------------------
# Verify VS Code CLI
# ---------------------------
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "VS Code CLI (code) not found in PATH." -ForegroundColor Red
    Write-Host "Open VS Code and install the 'code' shell command." -ForegroundColor Yellow
    exit 1
}

# ---------------------------
# Install VS Code Extensions
# ---------------------------
Write-Host "Installing VS Code extensions..." -ForegroundColor Cyan

Get-Content "./extensions.txt" | ForEach-Object {
    Write-Host "Installing $_"
    code --install-extension $_ --force
}

# ---------------------------
# Configure Git (Global)
# ---------------------------
Write-Host "Configuring Git..." -ForegroundColor Cyan

git config --global user.name "Jesse Brandon"
git config --global user.email "jessebrandon052@gmail.com"

git config --global core.editor "code --wait"
git config --global core.autocrlf true

git config --global init.defaultBranch main

git config --global pull.rebase true
git config --global push.default simple

git config --global credential.helper manager

# ---------------------------
# Install Python Tooling
# ---------------------------
Write-Host "Installing global Python tools..." -ForegroundColor Cyan

pip install --upgrade pip
pip install black flake8 isort pre-commit


# ---------------------------
# Apply VS Code Global Settings
# ---------------------------
Write-Host "Applying VS Code settings..." -ForegroundColor Cyan

$sourceSettings = ".\config\vscode\settings.json"
$targetSettings = "$env:APPDATA\Code\User\settings.json"

if (Test-Path $sourceSettings) {
    Copy-Item $sourceSettings $targetSettings -Force
    Write-Host "VS Code settings applied." -ForegroundColor Green
}
else {
    Write-Host "VS Code settings file not found in repo." -ForegroundColor Yellow
}



Write-Host "Workstation setup complete." -ForegroundColor Green