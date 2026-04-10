# Hermes Agent 安装配置 Skill

Hermes Agent 安装配置 Skill，用于 OpenClaw Agent 快速部署和管理 Hermes Agent。

## 功能

| 功能 | 说明 |
|------|------|
| **安装部署** | 克隆仓库、安装依赖、创建虚拟环境 |
| **更新重启** | 一键更新版本并重启网关 |
| **健康检查** | 诊断 API 连接、网关状态、配置问题 |
| **卸载清理** | 完全卸载或保留配置卸载 |
| **API 配置** | 支持 10+ 模型提供商（按需加载） |
| **网关配置** | 飞书/Telegram/Discord 网关配置（按需加载） |

## 文件结构

```
hermes-installer/
├── SKILL.md              # 主文档（安装/卸载/更新/健康检查）
├── README.md             # 说明文档
├── api-config.md         # API 配置模块（按需加载）
├── gateway-config.md     # 网关配置模块（按需加载）
└── scripts/              # 脚本文件
    ├── update-restart.sh     # Linux/macOS 更新脚本
    ├── update-restart.ps1    # Windows 更新脚本
    ├── uninstall.sh          # Linux/macOS 卸载脚本
    ├── uninstall.ps1         # Windows 卸载脚本
    ├── doctor.sh             # Linux/macOS 健康检查
    └── doctor.ps1            # Windows 健康检查
```

## 按需加载

| 模块 | 触发条件 |
|------|---------|
| `SKILL.md` | 默认加载（安装/卸载/更新） |
| `api-config.md` | 用户要求配置 API/模型提供商 |
| `gateway-config.md` | 用户要求配置网关/通知渠道 |

## 触发词

- 安装 Hermes
- 部署 Hermes Agent
- 配置 Hermes
- 配置 GLM / Kimi / OpenRouter
- 配置飞书 / Telegram / Discord
- Hermes 更新 / 卸载 / 健康检查

## 支持的模型提供商

### Coding Plan 端点

| 提供商 | 端点 |
|--------|------|
| 智谱 GLM | `https://open.bigmodel.cn/api/coding/paas/v4` |
| Kimi | `https://api.kimi.com/coding/v1` |
| 阿里云百炼 | `https://coding.dashscope.aliyuncs.com/v1` |
| 火山引擎 | `https://ark.cn-beijing.volces.com/api/coding/v3` |
| 腾讯云 | `https://api.lkeap.cloud.tencent.com/coding/v3` |

### 通用端点

- OpenRouter
- z.ai (GLM 国际版)
- Kimi/Moonshot
- 阿里云百炼
- 腾讯云混元
- 火山引擎
- 阶跃星辰

## 脚本使用

### 健康检查

```bash
# Linux/macOS
bash scripts/doctor.sh

# Windows
.\scripts\doctor.ps1
```

### 更新重启

```bash
# Linux/macOS
bash scripts/update-restart.sh

# Windows
.\scripts\update-restart.ps1
```

### 卸载

```bash
# Linux/macOS
bash scripts/uninstall.sh              # 完全卸载
bash scripts/uninstall.sh --keep-config # 保留配置

# Windows
.\scripts\uninstall.ps1           # 完全卸载
.\scripts\uninstall.ps1 -KeepConfig # 保留配置
```

## 相关链接

- Hermes Agent 官方文档：https://hermes-agent.nousresearch.com/docs/
- GitHub：https://github.com/NousResearch/hermes-agent
- OpenClaw：https://openclaw.ai

## 版本

- **版本**: 1.0.0
- **创建时间**: 2026-04-11
- **作者**: AutoClaw
