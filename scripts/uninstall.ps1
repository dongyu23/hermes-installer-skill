# Hermes Agent 卸载脚本 (Windows PowerShell)
# 用法: .\uninstall.ps1 [-KeepConfig]

param(
    [switch]$KeepConfig
)

$ErrorActionPreference = "Stop"
$HERMES_DIR = "$env:USERPROFILE\.hermes"

Write-Host "=== Hermes Agent 卸载 ===" -ForegroundColor Cyan
Write-Host ""

# 检查是否存在
if (-not (Test-Path $HERMES_DIR)) {
    Write-Host "❌ Hermes Agent 未安装，无需卸载" -ForegroundColor Red
    exit 0
}

# 停止网关
Write-Host "🛑 停止网关..." -ForegroundColor Yellow
$agentDir = Join-Path $HERMES_DIR "hermes-agent"
if (Test-Path $agentDir) {
    Set-Location $agentDir
    $activateScript = Join-Path $agentDir "venv\Scripts\Activate.ps1"
    if (Test-Path $activateScript) {
        & $activateScript
        try {
            hermes gateway stop 2>$null
        } catch {
            # 忽略错误
        }
    }
}

# 确认卸载
if ($KeepConfig) {
    Write-Host "⚠️  将删除程序文件，但保留配置文件" -ForegroundColor Yellow
    Write-Host ""
    $confirm = Read-Host "确认卸载? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "❌ 已取消" -ForegroundColor Red
        exit 0
    }
    
    # 保留配置，只删除程序
    Write-Host "🗑️ 删除程序文件..." -ForegroundColor Yellow
    $agentPath = Join-Path $HERMES_DIR "hermes-agent"
    $venvPath = Join-Path $HERMES_DIR "venv"
    if (Test-Path $agentPath) { Remove-Item -Recurse -Force $agentPath }
    if (Test-Path $venvPath) { Remove-Item -Recurse -Force $venvPath }
    Write-Host "✅ 卸载完成！配置文件保留在 $HERMES_DIR" -ForegroundColor Green
} else {
    Write-Host "⚠️  将完全删除 Hermes Agent 及所有配置" -ForegroundColor Yellow
    Write-Host "   配置文件: $HERMES_DIR\config.yaml"
    Write-Host "   环境变量: $HERMES_DIR\.env"
    Write-Host ""
    $confirm = Read-Host "确认完全卸载? (y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "❌ 已取消" -ForegroundColor Red
        exit 0
    }
    
    # 完全删除
    Write-Host "🗑️ 删除所有文件..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $HERMES_DIR
    Write-Host "✅ 完全卸载完成！" -ForegroundColor Green
}

Write-Host ""
Write-Host "💡 如需重新安装，请运行:" -ForegroundColor Cyan
Write-Host "   git clone https://github.com/NousResearch/hermes-agent.git `$env:USERPROFILE\.hermes\hermes-agent"
