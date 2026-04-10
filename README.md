<div align="center">

# 🚀 hermes-installer

**Hermes Agent 一键部署与管理工具**

*让 AI Agent 部署变得简单*

[![GitHub release](https://img.shields.io/github/v/release/dongyu23/hermes-installer-skill?include_prereleases)](https://github.com/dongyu23/hermes-installer-skill/releases)
[![GitHub license](https://img.shields.io/github/license/dongyu23/hermes-installer-skill)](https://github.com/dongyu23/hermes-installer-skill/blob/main/LICENSE)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-blue)](https://openclaw.ai)
[![Made with ❤️](https://img.shields.io/badge/Made%20with-❤️-red)](https://github.com/dongyu23)

</div>

---

> 💡 **"一个命令，完成部署。一键诊断，快速排错。"**

---

## ✨ 功能特性

| 功能 | 描述 |
|:----:|:-----|
| 📦 **一键安装** | 克隆仓库、安装依赖、创建虚拟环境，全程自动化 |
| 🔄 **更新重启** | 检测更新、自动重启网关，零停机升级 |
| 🏥 **健康检查** | 诊断 API 连接、网关状态、配置问题 |
| 🗑️ **智能卸载** | 支持完全卸载或保留配置卸载 |
| 🔌 **API 配置** | 支持 10+ 模型提供商，含 Coding Plan 专用端点 |
| 🌐 **网关配置** | 飞书 / Telegram / Discord 一键接入 |

---

## 🎯 支持的模型提供商

### Coding Plan 端点（推荐用于 Coding 场景）

| 提供商 | 端点 | 特点 |
|:------:|:-----|:-----|
| 智谱 GLM | `open.bigmodel.cn/api/coding/paas/v4` | 国产大模型 |
| Kimi | `api.kimi.com/coding/v1` | 长上下文 |
| 阿里云百炼 | `coding.dashscope.aliyuncs.com/v1` | 通义千问 |
| 火山引擎 | `ark.cn-beijing.volces.com/api/coding/v3` | 豆包系列 |
| 腾讯云 | `api.lkeap.cloud.tencent.com/coding/v3` | 不含混元 |
| 阶跃星辰 | `api.stepfun.com/step_plan/v1` | Step 系列 |

### 通用端点

OpenRouter · z.ai · Kimi/Moonshot · 阿里云百炼 · 腾讯云混元 · 火山引擎 · 阶跃星辰

---

## 🚀 快速开始

### 安装

```bash
# 一键安装到 OpenClaw
git clone https://github.com/dongyu23/hermes-installer-skill.git ~/.openclaw/skills/hermes-installer-1.0.0
```

### 使用

触发词：
- `安装 Hermes`
- `配置 GLM / Kimi / OpenRouter`
- `配置飞书 / Telegram / Discord`
- `Hermes 健康检查`

---

## 📁 文件结构

```
hermes-installer/
├── 📄 SKILL.md              # 主文档
├── 📄 api-config.md         # API 配置模块（按需加载）
├── 📄 gateway-config.md     # 网关配置模块（按需加载）
└── 📂 scripts/
    ├── 🔧 doctor.sh / .ps1      # 健康检查
    ├── 🔧 update-restart.sh / .ps1  # 更新重启
    └── 🔧 uninstall.sh / .ps1   # 卸载脚本
```

---

## 🏥 健康检查

```
╔════════════════════════════════════════╗
║     Hermes Agent 健康检查              ║
╚════════════════════════════════════════╝

📁 安装目录    ✅ 正常
🐍 虚拟环境    ✅ 正常
📄 配置文件    ✅ 正常
🔐 环境变量    ✅ 正常
🌐 网关状态    ✅ 运行中
🔌 API 连接    ✅ 可达
📋 错误日志    ✅ 无错误

╔════════════════════════════════════════╗
║  ✅ Hermes Agent 状态良好！            ║
╚════════════════════════════════════════╝
```

---

## 📊 按需加载

| 模块 | 触发条件 | 大小 |
|:----:|:---------|:----:|
| `SKILL.md` | 默认加载 | 2.6 KB |
| `api-config.md` | 配置 API/模型提供商 | 5.9 KB |
| `gateway-config.md` | 配置网关/通知渠道 | 2.8 KB |

**总计：~11 KB**，只加载需要的部分！

---

## 🔗 相关链接

- [Hermes Agent 官方文档](https://hermes-agent.nousresearch.com/docs/)
- [OpenClaw 官网](https://openclaw.ai)
- [ClawHub Skills 市场](https://clawhub.com)

---

<div align="center">

**[⬆ 返回顶部](#-hermes-installer)**

---

### 📄 License

MIT License © 2026 [dongyu23](https://github.com/dongyu23)

---

*Made with ❤️ by AutoClaw*

</div>
