<div align="center">

# 🚀 hermes-installer

**让 OpenClaw 替你管理 Hermes Agent**

*无需终端，省心部署*

[![MIT License](https://img.shields.io/badge/License-MIT-green)](https://github.com/dongyu23/hermes-installer-skill/blob/main/LICENSE)
[![OpenClaw Skill](https://img.shields.io/badge/OpenClaw-Skill-blue)](https://openclaw.ai)

</div>

---

> 💡 **"告诉 OpenClaw，它来搞定 Hermes"**

---

## ✨ 一站式服务

| 功能 | 说明 |
|:----:|:-----|
| 📦 **安装部署** | 让 AI 帮你克隆仓库、安装依赖、创建虚拟环境 |
| 🔌 **配置 API** | 告诉 AI 你的提供商，自动配置 Coding Plan 端点 |
| 🌐 **接入飞书** | 让 AI 帮你配置飞书机器人，一键配对用户 |
| 🏥 **智能诊断** | API 连不上？网关报错？AI 帮你排查 |
| 🗑️ **干净卸载** | 想重装？AI 帮你清理干净，不留残留 |

**全程对话完成，不用碰终端。**

---

## 🎯 Coding Plan 端点

| 提供商 | 端点 |
|:------:|:-----|
| 智谱 GLM | `open.bigmodel.cn/api/coding/paas/v4` |
| Kimi | `api.kimi.com/coding/v1` |
| 阿里云百炼 | `coding.dashscope.aliyuncs.com/v1` |
| 火山引擎 | `ark.cn-beijing.volces.com/api/coding/v3` |
| 腾讯云 | `api.lkeap.cloud.tencent.com/coding/v3` |
| 阶跃星辰 | `api.stepfun.com/step_plan/v1` |

---

## 📥 安装

### 方式一：通过 ClawHub 安装（推荐）

```bash
# 一键安装
npx clawhub install hermes-installer
```

安装后即可在 OpenClaw 中使用，无需其他配置。

> 💡 已发布到 ClawHub: [hermes-installer@1.0.0](https://clawhub.ai/skill/hermes-installer)

### 方式二：手动安装

```bash
git clone https://github.com/dongyu23/hermes-installer-skill.git ~/.openclaw/skills/hermes-installer-1.0.0
```

手动安装后需要重启 OpenClaw 网关。

---

## 📄 License

MIT License © 2026 [dongyu23](https://github.com/dongyu23)
