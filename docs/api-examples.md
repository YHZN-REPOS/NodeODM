# API 示例（curl）

以下示例默认 NodeODM 运行在 `http://127.0.0.1:3000`。

如果启用了 token 鉴权，请追加 `?token=YOUR_TOKEN`。  
如果未启用鉴权，请去掉该查询参数。

## 创建任务：`end-with=opensfm`，并且 `all.zip` 只包含 `opensfm`

```bash
curl -X POST "http://127.0.0.1:3000/task/new?token=YOUR_TOKEN" \
  -F 'name=opensfm-test' \
  -F 'options=[{"name":"end-with","value":"opensfm"}]' \
  -F 'outputs=["opensfm"]' \
  -F 'images=@/path/to/image1.jpg' \
  -F 'images=@/path/to/image2.jpg'
```

成功返回通常包含 `uuid`：

```json
{"uuid":"..."}
```

## 查询任务信息

```bash
curl "http://127.0.0.1:3000/task/<uuid>/info?token=YOUR_TOKEN"
```

## 获取任务日志输出

```bash
curl "http://127.0.0.1:3000/task/<uuid>/output?token=YOUR_TOKEN"
```

## 下载 `all.zip`

```bash
curl -L -o all.zip "http://127.0.0.1:3000/task/<uuid>/download/all.zip?token=YOUR_TOKEN"
```

## 无 token 的示例

```bash
curl -X POST "http://127.0.0.1:3000/task/new" \
  -F 'name=opensfm-test' \
  -F 'options=[{"name":"end-with","value":"opensfm"}]' \
  -F 'outputs=["opensfm"]' \
  -F 'images=@/path/to/image1.jpg'
```

## 说明

- `options` 必须是 JSON 数组，例如：
  `[{"name":"option-name","value":"option-value"}]`
- `outputs` 必须是 JSON 数组，内容是相对任务目录的路径。
- 传 `outputs` 会覆盖默认 `all.zip` 列表（不是追加）。
- 如果要保留默认打包行为，不要传 `outputs`。
- 对于大任务，也可以使用分段上传流程：
  `/task/new/init` -> `/task/new/upload/{uuid}` -> `/task/new/commit/{uuid}`。
