# Hermes Agent 健康检查脚本 (Windows PowerShell)
# 用法: .\doctor.ps1

$ErrorActionPreference = "Continue"
$HERMES_DIR = "$env:USERPROFILE\.hermes"
$HERMES_AGENT_DIR = "$HERMES_DIR\hermes-agent"
$ENV_FILE = "$HERMES_DIR\.env"
$CONFIG_FILE = "$HERMES_DIR\config.yaml"

$Errors = 0
$Warnings = 0

Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     Hermes Agent 健康检查              ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# 1. 检查安装目录
Write-Host "📁 检查安装目录..." -ForegroundColor Yellow
if (Test-Path $HERMES_AGENT_DIR) {
    Write-Host "  ✅ 安装目录存在: $HERMES_AGENT_DIR" -ForegroundColor Green
} else {
    Write-Host "  ❌ 安装目录不存在: $HERMES_AGENT_DIR" -ForegroundColor Red
    $Errors++
}

# 2. 检查虚拟环境
Write-Host ""
Write-Host "🐍 检查虚拟环境..." -ForegroundColor Yellow
$VenvPath = "$HERMES_AGENT_DIR\venv"
if (Test-Path $VenvPath) {
    Write-Host "  ✅ 虚拟环境存在" -ForegroundColor Green
    $ActivateScript = "$VenvPath\Scripts\Activate.ps1"
    if (Test-Path $ActivateScript) {
        Write-Host "  ✅ 激活脚本存在" -ForegroundColor Green
    } else {
        Write-Host "  ❌ 激活脚本不存在" -ForegroundColor Red
        $Errors++
    }
} else {
    Write-Host "  ❌ 虚拟环境不存在" -ForegroundColor Red
    $Errors++
}

# 3. 检查配置文件
Write-Host ""
Write-Host "📄 检查配置文件..." -ForegroundColor Yellow
if (Test-Path $CONFIG_FILE) {
    Write-Host "  ✅ config.yaml 存在" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  config.yaml 不存在" -ForegroundColor Yellow
    $Warnings++
}

if (Test-Path $ENV_FILE) {
    Write-Host "  ✅ .env 文件存在" -ForegroundColor Green
    
    # 检查环境变量
    Write-Host ""
    Write-Host "🔐 检查环境变量..." -ForegroundColor Yellow
    
    $envContent = Get-Content $ENV_FILE -Raw
    
    if ($envContent -match 'OPENAI_API_KEY=(.+)') {
        $apiKey = $Matches[1].Trim().Trim('"').Trim("'")
        if ($apiKey -and $apiKey -ne "") {
            Write-Host "  ✅ OPENAI_API_KEY 已设置" -ForegroundColor Green
        } else {
            Write-Host "  ⚠️  OPENAI_API_KEY 未设置" -ForegroundColor Yellow
            $Warnings++
        }
    } else {
        Write-Host "  ⚠️  OPENAI_API_KEY 未设置" -ForegroundColor Yellow
        $Warnings++
    }
    
    if ($envContent -match 'OPENAI_BASE_URL=(.+)') {
        $baseUrl = $Matches[1].Trim().Trim('"').Trim("'")
        if ($baseUrl -and $baseUrl -ne "") {
            Write-Host "  ✅ OPENAI_BASE_URL 已设置: $baseUrl" -ForegroundColor Green
        } else {
            Write-Host "  ⚠️  OPENAI_BASE_URL 未设置" -ForegroundColor Yellow
            $Warnings++
        }
    } else {
        Write-Host "  ⚠️  OPENAI_BASE_URL 未设置" -ForegroundColor Yellow
        $Warnings++
    }
} else {
    Write-Host "  ⚠️  .env 文件不存在" -ForegroundColor Yellow
    $Warnings++
}

# 4. 检查网关状态
Write-Host ""
Write-Host "🌐 检查网关状态..." -ForegroundColor Yellow
if (Test-Path "$HERMES_AGENT_DIR\venv\Scripts\Activate.ps1") {
    Push-Location $HERMES_AGENT_DIR
    try {
        & "$HERMES_AGENT_DIR\venv\Scripts\Activate.ps1"
        $status = hermes gateway status 2>&1
        Write-Host "  状态: $status" -ForegroundColor Gray
    } catch {
        Write-Host "  ⚠️  无法获取网关状态" -ForegroundColor Yellow
        $Warnings++
    }
    Pop-Location
} else {
    Write-Host "  ⚠️  无法检查（虚拟环境不存在）" -ForegroundColor Yellow
    $Warnings++
}

# 5. 测试 API 连接
Write-Host ""
Write-Host "🔌 测试 API 连接..." -ForegroundColor Yellow
if (Test-Path $ENV_FILE) {
    $envContent = Get-Content $ENV_FILE -Raw
    
    $apiKey = ""
    $baseUrl = ""
    
    if ($envContent -match 'OPENAI_API_KEY=(.+)') {
        $apiKey = $Matches[1].Trim().Trim('"').Trim("'")
    }
    if ($envContent -match 'OPENAI_BASE_URL=(.+)') {
        $baseUrl = $Matches[1].Trim().Trim('"').Trim("'")
    }
    
    if ($apiKey -and $baseUrl) {
        $apiEndpoint = "$baseUrl/chat/completions"
        
        try {
            $headers = @{
                "Authorization" = "Bearer $apiKey"
                "Content-Type" = "application/json"
            }
            $body = @{
                model = "test"
                messages = @(@{role="user"; content="hi"})
            } | ConvertTo-Json -Depth 2
            
            $response = Invoke-WebRequest -Uri $apiEndpoint -Method POST -Headers $headers -Body $body -TimeoutSec 10 -UseBasicParsing -ErrorAction SilentlyContinue
            Write-Host "  ✅ API 端点可达 (HTTP $($response.StatusCode))" -ForegroundColor Green
        } catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            if ($statusCode -in @(400, 401, 403, 404)) {
                Write-Host "  ✅ API 端点可达 (HTTP $statusCode)" -ForegroundColor Green
            } elseif ($_.Exception.Message -match "无法连接|超时|timeout") {
                Write-Host "  ❌ API 端点无法连接" -ForegroundColor Red
                $Errors++
            } else {
                Write-Host "  ⚠️  API 返回异常: $($_.Exception.Message)" -ForegroundColor Yellow
                $Warnings++
            }
        }
    } else {
        Write-Host "  ⚠️  API Key 或 Base URL 未配置" -ForegroundColor Yellow
        $Warnings++
    }
} else {
    Write-Host "  ⚠️  .env 文件不存在，跳过 API 测试" -ForegroundColor Yellow
}

# 6. 检查日志
Write-Host ""
Write-Host "📋 检查最近日志..." -ForegroundColor Yellow
$LOG_FILE = "$HERMES_DIR\logs\agent.log"
if (Test-Path $LOG_FILE) {
    $logContent = Get-Content $LOG_FILE -Raw
    $errorMatches = [regex]::Matches($logContent, "error", "IgnoreCase")
    $errorCount = $errorMatches.Count
    
    if ($errorCount -gt 0) {
        Write-Host "  ⚠️  发现 $errorCount 条错误日志" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  最近错误:"
        $errors = Select-String -Path $LOG_FILE -Pattern "error" -CaseSensitive:$false | Select-Object -Last 3
        foreach ($err in $errors) {
            Write-Host "    $($err.Line)" -ForegroundColor Gray
        }
        $Warnings++
    } else {
        Write-Host "  ✅ 未发现错误日志" -ForegroundColor Green
    }
} else {
    Write-Host "  ℹ️  日志文件不存在" -ForegroundColor Gray
}

# 汇总
Write-Host ""
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              检查结果汇总              ║" -ForegroundColor Cyan
Write-Host "╠════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  ❌ 错误: $Errors                            ║" -ForegroundColor Cyan
Write-Host "║  ⚠️  警告: $Warnings                            ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

if ($Errors -eq 0 -and $Warnings -eq 0) {
    Write-Host "✅ Hermes Agent 状态良好！" -ForegroundColor Green
    exit 0
} elseif ($Errors -eq 0) {
    Write-Host "⚠️  Hermes Agent 基本正常，但有 $Warnings 个警告" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "❌ Hermes Agent 存在 $Errors 个错误，请检查！" -ForegroundColor Red
    exit 1
}
