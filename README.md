# GuardGauge — 非想天则「破防槽」Mod

给《东方非想天则》(th123 1.10a) 加一个**破防槽 (Guard Crush Gauge)** 机制：
格挡时累积、不格挡时回落，槽满触发破防。当前是 **P0：只做槽的显示与累积/回落**，用来先把
编译与运行链路验证通过；P1 再接上真正的破防状态。

## 机制设计

| 项 | 值 | 说明 |
|---|---|---|
| 累积 | 0.012 / 帧 | 连续格挡约 83 帧（约 1.4 秒）充满 |
| 回落 | 0.004 / 帧 | 不格挡时约 250 帧回落完 |
| 触发 | 满槽 | 槽清零 + 红闪 45 帧（P0 仅视觉） |

- 判定：优先读 `CharacterManager::frameData->guarding`，兜底看动作编号是否落在
  `ACTION_RIGHTBLOCK_*` ~ `ACTION_WRONGBLOCK_*`（150–166，含空中格挡 158）。
- 左右双方独立计算，槽画在屏幕下方两侧（640×480 坐标系，y=430）。

## 目录结构

```
├── CMakeLists.txt          # 工程定义（x86 DLL，C++17，MSVC）
├── SokuLib/                # 内嵌的 mod 库（无需 submodule）
├── lib/                    # d3d9.lib / d3dx9.lib
├── src/main.cpp            # 全部逻辑与钩子
├── src/version.rc          # dll 版本资源
├── mod.json                # mod loader 识别的元数据
├── .github/workflows/build.yml   # GitHub Actions 云编译
└── deploy.ps1              # 一键装进游戏
```

## 编译

### 方式一：GitHub Actions（本机不装任何东西）

推到 GitHub 仓库后，Actions 自动在 `windows-2022` 上编译，产物在 run 页面的
**Artifacts → GuardGauge** 里（一个文件夹：`GuardGauge.dll` + `mod.json`）。

### 方式二：本地（需要 MSVC）

在 **x86 Native Tools Command Prompt** 里：

```bat
cmake -S . -B build -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

产物：`build\GuardGauge.dll`

## 安装到游戏

```powershell
powershell -ExecutionPolicy Bypass -File .\deploy.ps1
```

脚本会做三件事：
1. 建 `th123\modules\GuardGauge\`，放 `GuardGauge.dll` + `mod.json`
2. 备份 `ModLoaderSettings.json`
3. 在配置里加一条 `modules/GuardGauge/GuardGauge.dll: {enabled: true}`

也可以手动：把文件夹丢进 `th123/modules/`，进游戏主菜单按 **D** 启用。

## 已验证 / 待验证

- [x] 游戏版本匹配：本机 `th123.exe` MD5 = `DF35D1FBC7B583317ADABE8CD9F53B2E`，
      与 `SokuLib::targetHash` 完全一致 → `CheckVersion` 会通过
- [x] 所有用到的 SokuLib 符号（`VTable_BattleManager.onProcess/onRender`、
      `RectangleShape::setSize/setFillColor`、`FrameData::guarding`、`RDATA_SECTION_OFFSET`）
      已逐个在头文件里核对
- [ ] 编译通过（需要 Actions 或 MSVC）
- [ ] 游戏内实际显示效果

## 路线图

- **P0（当前）**：槽显示 + 累积/回落 + 满槽红闪，不改游戏状态
- **P1**：满槽触发强制破防（硬直 / 动作切换），双方状态一致
- **P2**：破防演出（特效 + 音效）、槽的贴图美化、可配置参数文件 `.ini`
- **P3**：联机双端一致性校验与 README 安装说明完善

## 注意

- 这是**改机制**的 mod：联机时双方都必须装同一版本，否则会不同步。
- 与 `PunishDisplay`、`TrialMode` 等已有 UI mod 共存时，注意绘制层级/位置是否重叠。
