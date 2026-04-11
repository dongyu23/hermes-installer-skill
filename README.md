<div align="center">

# hermes-installer.skill

**让 OpenClaw 替你管理 Hermes Agent**

*无需终端，省心部署*

[![MIT License](https://img.shields.io/badge/License-MIT-green)](https://github.com/dongyu23/hermes-installer-skill/blob/main/LICENSE)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-blue)](https://openclaw.ai)
[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-purple)](https://github.com/NousResearch/hermes-agent)

---

**本技能让 OpenClaw 具备系统管理 Hermes 的能力。安装/配置/更新/诊断/卸载，均可对话完成。**

[效果示例](#效果示例) · [安装](#安装) · [核心能力](#核心能力) · [技术细节](#技术细节)

</div>

---

## 效果示例

### 问：帮我安装 Hermes

```
OpenClaw ❯ 收到。确认以下信息：

安装位置：~/.hermes/hermes-agent
配置目录：~/.hermes
Python 版本：3.11

确认安装？(y/n)

> y

开始安装：
✅ 克隆仓库
✅ 安装 uv 工具
✅ 创建虚拟环境
✅ 安装依赖
✅ 生成配置文件

安装完成。你的 Hermes Agent 已就绪。
```

> 运用了**确认后执行**（避免误操作）、**自动化全流程**（无需手动）

### 问：帮我配置 GLM 的 API

```
OpenClaw ❯ 明白。请问你的 GLM API Key 是什么？

> glm-xxxxx

收到。正在配置 ~/.hermes/.env 中的 GLM 端点：

- 端点：open.bigmodel.cn/api/coding/paas/v4
- 模型：glm-4-plus

配置完成。现在可以启动 Hermes 了。
```

> 运用了**按需配置**（不一次性问完所有问题）、**环境变量管理**

### 问： Hermes 连不上 GLM 帮我看看

```
OpenClaw ❯ 开始诊断...

✅ 安装目录存在
✅ 虚拟环境正常
✅ 配置文件存在
✅ 环境变量已设置
❌ API 端点连通性：失败

问题定位：
网络无法访问 open.bigmodel.cn

建议：
1. 检查服务器防火墙/安全组是否放行 443 端口
2. 或配置代理/国内源

需要我帮你检查其他项吗？
```

> 运用了**分层诊断**（从基础设施到网络到应用）、**给出明确建议**

---

## 核心能力

| 能力 | 说明 | 触发方式 |
|------|------|----------|
| 📦 **一键安装** | 克隆仓库 + 安装依赖 + 创建虚拟环境 | "安装 Hermes" |
| 🔄 **版本更新** | 拉取最新代码 + 重启网关 | "更新 Hermes" |
| 🔌 **API 配置** | 配置 GLM/Kimi/阿里云/火山/腾讯/阶跃 | "配置 XXX 的 API" |
| 🌐 **飞书接入** | 配置飞书机器人 + 绑定用户 | "接入飞书" |
| 🏥 **智能诊断** | 排查安装/配置/网络/运行时问题 | "Hermes 坏了" / "连不上" |
| 🗑️ **干净卸载** | 清理所有文件，保留可选配置 | "卸载 Hermes" |

---

## 安装

### 方式一：ClawHub（推荐）

```bash
npx clawhub install hermes-installer
```

### 方式二：SkillHub

```bash
# 检查 CLI
skillhub --version

# 安装 CLI（如未安装）
curl -fsSL https://skillhub-1388575217.cos.ap-guangzhou.myqcloud.com/install/install.sh | bash -s -- --cli-only

# 安装技能
skillhub install hermes-installer
```

### 方式三：手动

```bash
git clone https://github.com/dongyu23/hermes-installer-skill.git ~/.openclaw/skills/hermes-installer-1.0.0
```

安装后重启 OpenClaw。

---

## 使用方式

安装后，在 OpenClaw 中直接说话：

```
> 帮我安装 Hermes
> 配置 Kimi 的 API
> 帮我更新到最新版本
> Hermes 连不上网，帮我看看
> 卸载 Hermes
```

---

## 技术细节

### 支持的模型提供商

| 提供商 | 端点 | 环境变量 |
|--------|------|----------|
| 智谱 GLM | `open.bigmodel.cn/api/coding/paas/v4` | `GLM_API_KEY` |
| Kimi | `api.kimi.com/coding/v1` | `KIMI_API_KEY` |
| 阿里云百炼 | `coding.dashscope.aliyuncs.com/v1` | `DASHSCOPE_API_KEY` |
| 火山引擎 | `ark.cn-beijing.volces.com/api/coding/v3` | `VOLCENGINE_API_KEY` |
| 腾讯云 | `api.lkeap.cloud.tencent.com/coding/v3` | `TENCENT_API_KEY` |
| 阶跃星辰 | `api.stepfun.com/step_plan/v1` | `STEPFUN_API_KEY` |

### 配置文件

- 程序目录：`~/.hermes/hermes-agent`
- 配置目录：`~/.hermes/`
- 环境变量：`~/.hermes/.env`
- 运行日志：`~/.hermes/logs/`

### 系统要求

- Linux / macOS / Windows
- Python 3.11+
- Git

---

## 仓库结构

```
hermes-installer-skill/
├── README.md                    # 本文件
├── SKILL.md                     # 技能核心定义
├── api-config.md                # API 配置详细参数
├── gateway-config.md            # 网关配置（飞书/Telegram/Discord）
└── scripts/
    ├── update-restart.sh/ps1    # 更新并重启
    ├── uninstall.sh/ps1         # 卸载
    └── doctor.sh/ps1            # 诊断
```

---

## 技术来源

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — 官方仓库
- [Hermes 文档](https://hermes-agent.nousresearch.com/docs/) — 官方文档
- [Coding Plan](https://platform.zhipuai.cn/pricing) — 智谱 API 定价

---

## 关于

**作者**：dongyu23

** License**：MIT — 随便用

