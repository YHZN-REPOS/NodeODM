# 阶段归档（2026-03）

本文用于归档当前阶段已经完成的工作，方便后续继续维护或交接。

## 本阶段目标

- 让 GPU 镜像构建流程更稳定、更容易复现。
- 在 Web UI 中开放 `all.zip outputs` 能力，避免每次都手工改接口请求。
- 把当前阶段涉及的使用方法、接口示例和表单说明补齐到仓库文档中。

## 已完成事项

### 1. GPU 构建链路稳定化

- `Dockerfile.gpu` 调整为先复制项目文件，再执行依赖安装脚本。
- 构建阶段会统一 shell 脚本的 LF 行尾，减少 `$'\r'` 相关报错。
- `install_deps.sh` 增加 `ca-certificates`，固定 `nodemon@2.0.22`，并为 `npm install --production` 添加重试。
- `.gitattributes` 已约束关键脚本与 Dockerfile 的行尾格式。

### 2. Web UI 增加 `all.zip outputs`

- 前端表单新增 `all.zip outputs (optional JSON array)` 输入框。
- 提交任务前会校验输入值是否为合法 JSON 数组。
- 当传入 `outputs` 时，NodeODM 会使用该列表覆盖默认 `all.zip` 打包内容。

示例：

```json
["opensfm", "odm_report/report.pdf"]
```

### 3. 文档整理

- `README.md`：改为当前分支的阶段入口页。
- `docs/task-form-guide.md`：说明 Web 表单字段含义和默认 `all.zip` 列表。
- `docs/api-examples.md`：提供 `curl` 提交、查询、下载示例。
- `CHANGELOG.md`：记录当前阶段新增的 UI 能力和文档沉淀。

## 当前建议用法

- 只想保留默认打包行为时，不要传 `outputs`。
- 只想要部分结果时，再传 `outputs` 覆盖默认列表。
- 需要调试中间成果时，可结合 `end-with` 与自定义 `outputs` 一起使用。

## 当前阶段边界

- 本仓库 `package.json` 中没有可直接使用的自动化测试脚本，文档整理后仍需以实际构建和运行验证为主。
- `docs/index.adoc` 与 `docs/swagger.json` 仍属于上游接口文档源，本阶段主要补的是面向当前使用场景的中文说明。

## 建议后续工作

- 如后续继续扩展前端表单，可同步补充字段级别的示例输入。
- 如要做正式发布，建议再增加一次 GPU 镜像构建与任务提交流程的实机验证记录。
