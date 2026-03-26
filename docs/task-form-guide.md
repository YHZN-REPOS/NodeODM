# 任务提交表单说明

本文说明内置 Web 页面里任务提交表单各个区域的含义。

## 输入区域

### Images and GCP File (optional)

用于上传图片和可选辅助文件。

常见可选文件：
- `geo.txt`
- `image_groups.txt`
- `*.txt`（GCP 文件）
- `seed.zip`
- `align.las`、`align.laz`、`align.tif`

说明：
- 在文件上传模式下，不选文件直接启动任务会失败。
- GCP 文件建议使用 `.txt` 扩展名。

### URL to zip file with Images and GCP File (optional)

这是另一种输入方式：由 NodeODM 从远程 URL 下载 zip 包。  
zip 包中可包含图片和上述辅助文件。

### Start Task

创建并提交任务。

行为：
- 文件模式：先初始化任务，再上传文件，最后提交。
- URL 模式：携带 `zipurl` 直接创建任务。

## 固定高级字段

### Project Name

任务名称（可选）。  
留空时，NodeODM 会自动生成带时间戳的名称。

### generate 2D and potree point cloud tiles

用于控制后处理是否启用：
- 勾选：启用后处理。
- 不勾选：跳过后处理。

内部参数是 `skipPostProcessing`，与勾选状态相反。

### webhook callback url (optional)

任务结束后（成功或失败）回调的 URL。  
如果返回不是 200，会自动重试多次。

### all.zip outputs (optional JSON array)

用于覆盖 `all.zip` 的打包内容。  
值必须是 JSON 数组，路径相对于任务目录。

关键行为：
- 不传或留空 `outputs`：使用 NodeODM 内置默认打包列表。
- 传了 `outputs`：会完整替换默认列表（不是追加/合并）。
- 压缩时只会加入“实际存在”的路径。

示例：

```json
["opensfm", "odm_report/report.pdf"]
```

### 默认 `all.zip` 打包列表

当未提供 `outputs` 时，会使用以下默认列表：

```json
[
  "odm_orthophoto/odm_orthophoto.tif",
  "odm_orthophoto/odm_orthophoto.tfw",
  "odm_orthophoto/odm_orthophoto.png",
  "odm_orthophoto/odm_orthophoto.wld",
  "odm_orthophoto/odm_orthophoto.mbtiles",
  "odm_orthophoto/odm_orthophoto.kmz",
  "odm_orthophoto/odm_orthophoto_extent.dxf",
  "odm_orthophoto/cutline.gpkg",
  "odm_georeferencing",
  "odm_texturing",
  "odm_dem/dsm.tif",
  "odm_dem/dtm.tif",
  "dsm_tiles",
  "dtm_tiles",
  "odm_dem/dsm.euclideand.tif",
  "odm_dem/dtm.euclideand.tif",
  "orthophoto_tiles",
  "potree_pointcloud",
  "entwine_pointcloud",
  "3d_tiles",
  "images.json",
  "cameras.json",
  "task_output.txt",
  "log.json",
  "odm_report"
]
```

如果你要自定义 `outputs` 且希望与默认行为一致，请先复制这整份列表再修改。

## 动态 ODM 参数区（Show Options）

这部分参数由当前引擎的 `/options` 动态加载。

使用说明：
- `Show Options` / `Hide Options`：显示或隐藏高级参数。
- 标签格式：`option-name (domain)`。
- 蓝色 `i` 按钮：显示服务端返回的参数说明。
- 灰色重置按钮：恢复默认值。
- 输入框留空：表示使用默认值。

## 常用参数

### end-with

在指定阶段提前结束流程。  
适合调试或只跑部分产物。

### rerun-from

从指定阶段重新开始执行。  
适合已有中间结果时做局部重跑。

### min-num-features

每张图最少提取的特征点数量。  
数值更高可能改善困难数据集的匹配，但会增加耗时与内存占用。

### feature-type

特征点/描述子算法类型。  
常见选项：`akaze`、`hahog`、`orb`、`sift`。

## 实践建议

- 第一轮先尽量使用默认参数。
- 每次只改少量参数，便于定位问题。
- 参数含义以界面 `i` 按钮提示为准（对应当前引擎版本）。
