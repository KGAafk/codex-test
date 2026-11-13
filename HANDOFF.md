# 非想天则 Mod 项目交接文档

> 生成时间：2026-11-14 04:50（Asia/Shanghai）
> 交接对象：接手的 AI / 开发者
> 目标读者：需要在不了解上下文的情况下，继续这个项目

---

## 0. 一句话现状

已经做出并部署了两个可用 mod（`GuardGauge` 破防槽、`BossMode` Boss 强化），编译走 GitHub Actions 云构建，安装用脚本一键完成；**当前卡在一个未验证的问题上：社区 AI 工具「神AI」能否在大厅联机对局中接管角色**。本地对局已确认可用，联机对局只测过一次且测试过程被污染（见 §7）。

---

## 1. 用户目标（按时间演进）

1. 最初：找回丢失的《东方绯想天则》——已找到，路径见 §2
2. 然后：让 AHK 一键出招脚本支持 F11 启停——已完成（`非想天则一键必杀_F11开关.ahk`）
3. 然后：做一个「神早苗」Boss——体型放大、血量增加、伤害增加——已完成（`BossMode`）
4. 然后：让「神AI」控制自己这侧的角色，在大厅和朋友对战时使用——**当前卡点**

---

## 2. 环境事实

### 2.1 机器

| 项 | 值 |
|---|---|
| OS | Windows（中文系统，ANSI 代码页 GBK） |
| 用户 | `C:\Users\29287` |
| 磁盘 | 仅 C:（153 GB）、D:（800 GB），无外接盘 |
| 编译器 | **无**（无 VS / MSVC / CMake / clang / gcc） |
| git | `C:\Program Files\Git`，credential helper = `manager`（GCM） |
| git 代理坑 | 全局 `http.proxy = 127.0.0.1:7897`（Clash 未运行）→ **所有 git 命令必须加 `-c http.proxy= -c https.proxy=`** |

### 2.2 游戏

```
D:\touhou\【完整包】非想天则整合包2026-10-18\
├── SokuLauncher.exe
├── [ 启动游戏  检测更新 ] +Swarm+TSK.bat
├── th123\
│   ├── th123.exe          ← 4.59 MB, MD5 DF35D1FBC7B583317ADABE8CD9F53B2E (= 1.10a)
│   ├── d3d9.dll           ← 562 KB, SokuModLoader 0.4.2.3 (PinkySmile)
│   ├── ModLoaderSettings.json  ← mod 启用清单（权威配置）
│   ├── SWRSToys.ini            ← 自动生成，勿手改
│   ├── swarm.exe / SWARM-CORE.EXE  ← Swarm 联机环境
│   └── modules\           ← 33 个已装 mod
│        ├── giuroll\      ← 回滚式联机（0.6.18）
│        ├── PracticeEX\ TrialMode\ PunishDisplay\ shady-loader\
│        ├── SokuLobbiesMod\ SwarmMod\ th123intl\ DisplayManager\ ...
│        ├── GuardGauge\   ← 本项目（新增）
│        └── BossMode\     ← 本项目（新增）
```

**版本校验**：`SokuLib::targetHash` 硬编码的 16 字节 = `th123.exe` 的 MD5，本机完全一致，所以 `CheckVersion()` 必过。

### 2.3 神AI（社区 AI 工具）

```
D:\touhou\神AI\th123ai\
├── th123_ai.exe        ← 主程序，SHA256 ff8fb443c227c0eeb0e1ff6f92ec0afed965d4f95e07f35247c3fb8579ab862f
├── th123_ai.ini        ← 配置（Shift-JIS 编码）
├── script\             ← 62 个角色 AI 脚本（00_reimu … 19_suwako）
│   └── 15_sanae_main.ai
└── document.txt / Readme.txt（UTF-16LE）
```

- AI 机签：`th123\profile\AI（请勿复制修改）.pf`（已复制）
- **Windows Defender 判定 `Trojan:Win32/Remhead!rfn`（严重级 5）**，已添加文件夹排除项 `D:\touhou\神AI`（用户知情并同意）
- 关键配置项（`th123_ai.ini`）：
  - `Player=1` / `Player=2` —— 控制哪一侧
  - `StartupAI=script\15_sanae_main.ai` —— 自动加载的脚本
  - `StartupTH123=` —— 游戏 exe 路径；**留空时每次启动都会弹「ファイルを開く」对话框索要 th123.exe**

---

## 3. 代码仓库与构建

### 3.1 仓库

- 地址：**https://github.com/KGAafk/codex-test**（沿用了用户原来的空仓库，分支 `main`）
- 本地路径：`C:\Users\29287\Documents\deepseek-harness\default-workspace\soku-mod`
- 推送凭据：GCM 已存用户 OAuth（`gho_` 开头）；临时导出的 token 文件已删除
- 推送命令（注意代理参数）：
  ```powershell
  cd "C:\Users\29287\Documents\deepseek-harness\default-workspace\soku-mod"
  git -c http.proxy= -c https.proxy= push
  ```

### 3.2 构建（GitHub Actions，无本地编译）

工作流：`.github/workflows/build.yml`
- runner `windows-2022`，`ilammy/msvc-dev-cmd@v1` + `arch: x86`
- `cmake -S . -B build -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release` → `cmake --build build`
- 打包 `pkg/GuardGauge`、`pkg/BossMode`，作为 artifact **`soku-mods`** 上传
- 触发：push 到 main，或手动 `workflow_dispatch`

**用 API 取产物**（需要带 token）：
```
GET /repos/KGAafk/codex-test/actions/runs/<run_id>/artifacts
GET /repos/KGAafk/codex-test/actions/runs/<run_id>/artifacts/<artifact_id>/zip
```

### 3.3 工程结构

```
soku-mod/
├── CMakeLists.txt          # 两个 target：GuardGauge、BossMode
├── SokuLib/                # 内嵌（1.6 MB，无 submodule，避免 Actions 拉取失败）
├── lib/                    # d3d9.lib / d3dx9.lib（.gitignore 已开例外）
├── src/main.cpp            # GuardGauge
├── src_boss/main.cpp       # BossMode
├── mod.json                # GuardGauge 元数据
├── mod.boss.json           # BossMode 元数据（打包时改名 mod.json）
├── BossMode.ini            # BossMode 配置（GBK 编码）
├── deploy.ps1              # 安装脚本（支持单 dll 或整个产物目录）
└── switch-mode.ps1         # 切换「AI 控哪侧 / Boss 强化哪侧」
```

---

## 4. 已实现的功能

### 4.1 GuardGauge —— 破防槽（P0，仅视觉）

- 每帧读 `CharacterManager::objectBase.frameData->frameFlags.guarding` + 动作号兜底（150–166 含空中格挡）
- 槽值：格挡时 `+0.012/帧`，否则 `-0.004/帧`；满槽清零并红闪 45 帧
- 绘制：左右各一条 120×10 槽，位于 (20,400) 与 (500,400)，**空槽也画**（否则不动时看不到）
- **尚未实现 P1**：满槽没有真正触发强制破防（不改游戏状态）
- 日志：`th123\GuardGauge.log`，每 120 帧记录双方 action/guard/槽值

### 4.2 BossMode —— 神早苗 Boss 化

配置 `th123\modules\BossMode\BossMode.ini`（**GBK 编码**，因为 mod 用 `GetPrivateProfileIntA` 读取）：

```ini
[Boss]
Side=2              ; 1=左(P1) 2=右(P2)
Character=15        ; 早苗=15；-1=不限角色
HpMultiplier=2.5    ; 上限 3.2（hp 是 signed short）
DamageMultiplier=2.0
ScaleMultiplier=1.6
```

实现要点：
- **血量**：直接写 `objectBase.hp = 10000 * HpMultiplier`。`ObjectManager` **没有 maxHP 字段**（血量上限是引擎常量 10000），所以 hp > 10000 期间血条保持满格
- **伤害**：把该角色每个 `FrameData` 的 `damage` / `spiritDamage` 各乘一次（用 `unordered_set<void*>` 记录已处理过的指针，避免重复放大）
- **体型**：每帧写 `objectBase.renderInfos.scale = {s,s}`（纯视觉，**判定框不变**）
- 日志：`th123\BossMode.log`，记录 `boss = side N, characterIndex M` 与 `hp set to XXXX`

### 4.3 部署脚本

```powershell
# 装整个产物目录（artifacts/soku-mods 解压后）
powershell -ExecutionPolicy Bypass -File .\deploy.ps1 -Source "<解压目录>"

# 只装单个 dll
powershell -ExecutionPolicy Bypass -File .\deploy.ps1 -Dll "<x>.dll" -Name <模块名>
```
行为：建 `modules\<名字>\`，复制 dll + mod.json + 附加 ini，备份并改写 `ModLoaderSettings.json` 里 `modules/<名字>/<名字>.dll` 的 `enabled`

### 4.4 模式切换

```powershell
# AI 控 1P + 1P 强化（朋友打你的强化 AI）
.\switch-mode.ps1 -Mode ai1p -Character 15

# AI 控 2P + 2P 强化（你自己打 Boss）
.\switch-mode.ps1 -Mode boss2p -Character 15
```
同时改 `th123_ai.ini` 的 `Player`/`StartupAI` 和 `BossMode.ini` 的 `Side`/`Character`

### 4.5 AHK 脚本（早期的独立产物）

`C:\Users\29287\Desktop\全部\非想天则一键必杀_F11开关.ahk`
- n/m/q/e 四个一键必杀宏（点方向 → 下+方向+K/L），时序 30/30/80 ms
- F11 全局启停；`#If` 限定只在游戏窗口生效
- 需要 UTF-8 **BOM** + CRLF，否则 AHK 读中文乱码
- 文件内有 `#Requires AutoHotkey v1.1`，因为机器装的是 AHK v2.0.26（v1 解释器在 `D:\hotkey\v1.1.37.02`）

---

## 5. 关键技术知识（踩过的坑，务必保留）

### 5.1 SokuLib API

| 用途 | 正确写法 | 错误写法（会编译失败或无效） |
|---|---|---|
| 角色对象 | `charMgr.objectBase`（类型 `ObjectManager`） | — |
| 当前动作 | `objectBase.action` | `charMgr.action`（不存在） |
| 帧数据 | `objectBase.frameData`，格挡位在 `.frameFlags.guarding` | `frameData->guarding`（不存在） |
| 血量 | `objectBase.hp`（short） | `objectBase.maxHP`（不存在） |
| 颜色 | `SokuLib::DrawUtils::DxSokuColor` | `SokuLib::DxSokuColor`（不在根命名空间） |
| 绘制矩形 | `RectangleShape`，先 `setSize` 再 `setPosition` | 顺序反了顶点不更新 |
| 钩子 | `TamperDword(&VTable_BattleManager.onProcess, fn)` | — |

### 5.2 编译坑

1. **`std::min/max` 被 windows.h 宏破坏** → 顶部 `#define NOMINMAX`，并写成 `(std::min)(a,b)`
2. **`SokuLib` 自带的测试目标编不过**（它自己的 API 已变）→ `add_subdirectory(SokuLib EXCLUDE_FROM_ALL)`
3. **成员函数指针不能转 `void*`** → 日志里只打印 `ptr != nullptr`
4. 工程必须产出 **32 位 x86**（`Machine = 0x14C`），否则 loader 不加载

### 5.3 编码坑（这个项目栽了三次）

| 文件类型 | 正确编码 | 原因 |
|---|---|---|
| `.ps1`（含中文） | UTF-8 **带 BOM** + CRLF | PowerShell 5.1 无 BOM 会按 ANSI 解析，中文把字符串截断 |
| `.ahk`（含中文） | UTF-8 **带 BOM** + CRLF | 同上 |
| `BossMode.ini` | **GBK** | mod 用 ANSI API 读取 |
| `mod.json` | UTF-8（无 BOM 亦可） | JSON 解析 |
| 项目里其他源文件 | UTF-8 | — |

### 5.4 其它

- 游戏运行时 `GuardGauge.dll` / `BossMode.dll` 被占用，**替换前必须先关 th123**
- `th123_ai.exe` 被 Defender 判木马，已加排除；**若排除项被清掉，exe 会被直接删除**
- 游戏窗口标题被整合包改成 `东方非想天则 Giuroll 0.6.18-0-alpha1-hagb CN`，不是标准的 `東方非想天則 ver1.10a` —— 这可能是神AI 无法自动识别已运行游戏、转而自行启动的原因
- 游戏**失去前台焦点就不读键盘**；联机对局不会因此暂停，会造成「1P 不动、2P 正常」的假象

---

## 6. 神AI 使用现状

### 6.1 已确认

- 它能**自行启动游戏**（选择 th123.exe 后打印「非想天則を自動起動します」）
- 启动后会依次显示状态：`Start Menu` → `Battle 1P:<hp> 2P:<hp>` → 联机时显示 `Net <名字> VS <名字>`
- **本地对局可用**：日志显示 1P 最近 40 帧中 39 帧有动作，含 `action=4/5`（前进/后退）等受控移动
- 启动顺序：**先启动 th123_ai.exe**（让它自己拉游戏），再进对局；若先开游戏，它会认不到并另开一个实例（曾出现两个 th123 进程）

### 6.2 未确认（核心待办）

**大厅联机对局中，神AI 是否会发送输入？**

只有一次观测：AI 窗口已显示 `Net 666(...) VS shrimp(...)`（确认识别到对局），但 `GuardGauge.log` 里 1P 连续 35 帧 `action=0` 完全不动。

**该次观测不可信**，因为排查过程中脚本多次对 AI 控制台执行 `ShowWindow` / `SetForegroundWindow`，把焦点从游戏上抢走（见 §5.4 最后一条）。

需要复现测试：开大厅对局 → 全程不切窗口 → 看 `GuardGauge.log` 里 1P 是否有 `action != 0`。

---

## 7. 待办与建议（按优先级）

1. **验证联机 AI**：按 §6.2 复测。若 1P 仍全程 `action=0`，判定神AI 在 Net 模式不注入输入
2. **若联机不可行**：改走串流方案 —— 本地同屏（AI 控一侧 + 朋友远程连入，Parsec / Steam 远程同乐），延迟 20–40 ms
3. **GuardGauge P1**：满槽触发真正破防（动作切换/硬直），需处理联机双端一致性
4. **BossMode 待修**：
   - 若双方同角色，伤害放大可能因 FrameData 共用而误伤（未验证）
   - 血条在 10000 以上保持满格，观感上有"打不动"的错觉
   - 体型放大不影响判定框
5. **可选**：把 `StartupTH123` 写进 `th123_ai.ini` 以跳过每次的选文件对话框（路径含中文，ini 为 Shift-JIS，直写会乱码；可考虑符号链接出纯 ASCII 路径）

---

## 8. 常用命令速查

```powershell
# 推送代码（必须带代理参数）
cd "C:\Users\29287\Documents\deepseek-harness\default-workspace\soku-mod"
git -c http.proxy= -c https.proxy= push

# 部署产物
powershell -ExecutionPolicy Bypass -File .\deploy.ps1 -Source "<artifact 解压目录>"

# 切换模式
powershell -ExecutionPolicy Bypass -File .\switch-mode.ps1 -Mode ai1p -Character 15
powershell -ExecutionPolicy Bypass -File .\switch-mode.ps1 -Mode boss2p -Character 15

# 看日志（判断 mod 是否生效）
Get-Content "D:\touhou\【完整包】非想天则整合包2026-10-18\th123\BossMode.log" -Tail 20
Get-Content "D:\touhou\【完整包】非想天则整合包2026-10-18\th123\GuardGauge.log" -Tail 20
```

角色编号：0 灵梦 1 魔理沙 2 咲夜 3 爱丽丝 4 帕秋莉 5 妖梦 6 蕾米莉亚 7 幽幽子 8 紫 9 萃香 10 铃仙 11 文 12 小町 13 衣玖 14 天子 **15 早苗** 16 琪露诺 17 美铃 18 空 19 诹访子

---

## 9. 边界说明

- 大厅里用 AI 代打属于作弊；用户明确说是在**自己和朋友的房间**里玩，属于双方知情的私下玩法。若后续扩展到公开匹配，应拒绝
- Defender 排除项 `D:\touhou\神AI` 是用户知情同意的，只对该文件夹生效
