# NodeODM 分支：阶段归档与 GPU 使用说明

这个分支当前主要聚焦两件事：

1. 稳定 GPU 镜像的构建与运行流程。
2. 补齐 NodeODM Web UI 中 `all.zip outputs` 功能的使用文档，方便当前阶段继续交付和复用。

上游项目（完整原始文档与 API 背景）：
https://github.com/OpenDroneMap/NodeODM

## 当前阶段已完成内容

- GPU Docker 构建流程已做稳定化处理，降低脚本行尾、依赖安装和构建顺序导致的失败概率。
- Web UI 已支持配置 `all.zip outputs`，可在任务提交时自定义最终打包内容。
- 仓库已补充表单说明、API/curl 示例和阶段归档文档，便于后续接手。

## 快速开始

构建 GPU 镜像：

```bash
git pull
docker build --no-cache -f Dockerfile.gpu -t nodeodm:gpu .
```

启动容器：

```bash
docker run -p 3000:3000 --gpus all nodeodm:gpu
```

Windows 数据卷挂载示例：

```bash
docker run --rm --name nodeodm -p 3000:3000 --gpus all -v G:\guoyujian\odm-data:/var/www/data nodeodm:gpu
```

## 本分支关键改动

- `Dockerfile.gpu` 先复制项目文件，再执行 `install_deps.sh`。
- `Dockerfile.gpu` 在构建时统一 shell 脚本行尾格式。
- `install_deps.sh` 增加 `ca-certificates`，固定 `nodemon@2.0.22`，并为 `npm install --production` 增加重试。
- `.gitattributes` 强制 `*.sh`、`Dockerfile`、`Dockerfile.*` 使用 LF 行尾。
- Web UI 新增 `all.zip outputs` 输入框，并在提交前校验 JSON 数组格式。

## 文档导航

- 阶段归档：`docs/archive-2026-03.md`
- 任务提交表单说明：`docs/task-form-guide.md`
- API / curl 示例：`docs/api-examples.md`
- 上游 OpenAPI/Asciidoc 源：`docs/index.adoc`
- 上游 Swagger JSON：`docs/swagger.json`

## 使用建议

- 如果你希望保留 NodeODM 默认的 `all.zip` 打包行为，不要传 `outputs`。
- 如果你传了 `outputs`，它会完整覆盖默认列表，而不是追加。
- 若需要继续扩展表单字段或联调接口，优先对照 `docs/task-form-guide.md` 和 `docs/api-examples.md`。
