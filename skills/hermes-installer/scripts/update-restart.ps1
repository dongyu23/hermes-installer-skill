# Hermes Agent 更新并重启网关脚本 (Windows PowerShell)
# 用法: .\update-restart.ps1

$ErrorActionPreference = "Stop"
$HERMES_DIR = "$env:USERPROFILE\.hermes\hermes-agent"

Write-Host "=== Hermes Agent 更新并重启 ===" -ForegroundColor Cyan
Write-Host ""

# 检查目录是否存在
if (-not (Test-Path $HERMES_DIR)) {
    Write-Host "❌ 错误: Hermes Agent 未安装在 $HERMES_DIR" -ForegroundColor Red
    exit 1
}

Set-Location $HERMES_DIR

# 激活虚拟环境
Write-Host "📦 激活虚拟环境..." -ForegroundColor Yellow
& ".\venv\Scripts\Activate.ps1"

# 停止网关
Write-Host "🛑 停止网关..." -ForegroundColor Yellow
try {
    hermes gateway stop 2>$null
} catch {
    # 忽略错误
}

# 检查更新
Write-Host "🔍 检查更新..." -ForegroundColor Yellow
hermes update

# 启动网关
Write-Host "🚀 启动网关..." -ForegroundColor Yellow
Start-Process -FilePath "hermes" -ArgumentList "gateway", "run" -NoNewWindow

# 等待启动
Start-Sleep -Seconds 3

# 检查状态
Write-Host ""
Write-Host "📊 网关状态:" -ForegroundColor Cyan
hermes gateway status

Write-Host ""
Write-Host "✅ 更新并重启完成！" -ForegroundColor Green
