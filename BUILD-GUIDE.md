# 用 GitHub 仓库编译非想天则 Mod —— 完整指南

> 适用：本机没有 Visual Studio / MSVC 的情况（这台机器就是这样）
> 原理：代码推到 GitHub，由 GitHub 的 Windows 服务器用 MSVC 编译，编译好的 DLL 作为 artifact 下载回来装进游戏
> 你这边只上传源码（约 1.7 MB）、下载产物（约 0.2 MB），**不消耗安装编译器的 4–6 GB 流量**

---

## 一、整体流程图

```
本地改代码
   │
   ├─ git add / commit
   ├─ git push  ──────────────► GitHub 仓库 (main 分支)
   │                              │
   │                              ├─ 触发 Actions（build.yml）
   │                              │    ├─ checkout
   │                              │    ├─ 装 MSVC (x86) + CMake
   │                              │    ├─ cmake 配置 + 编译
   │                              │    └─ 打包 pkg/GuardGauge、pkg/BossMode
   │                              │
   │                              └─ 产物挂到这次 run 的 Artifacts
   │
   └─ 下载 artifact (soku-mods.zip)
         │
         └─ deploy.ps1 -Source <解压目录>  ──► 装进 th123\modules\ 并注册
```

---

## 二、一次性准备

### 2.1 仓库

当前用的仓库：**https://github.com/KGAafk/codex-test**（分支 `main`）

要新建一个的话：
1. GitHub 网页 → New repository → 名字随意（如 `soku-mods`）→ **不要**勾选 "Add a README"
2. 本地仓库接上去：
   ```powershell
   cd "C:\Users\29287\Documents\deepseek-harness\default-workspace\soku-mod"
   git remote set-url origin https://github.com/KGAafk/<新仓库名>.git
   ```

### 2.2 推送凭据

两种方式，二选一：

**方式 A：GCM 浏览器授权（当前在用）**
第一次 `git push` 会弹出 GitHub 授权页（Edge 里已登录），点一次 **Authorize** 即可，凭据存进 Windows 凭据管理器，之后免登录。

**方式 B：Personal Access Token**
1. https://github.com/settings/personal-access-tokens/new
2. Repository access → Only select repositories → 选这个仓库
3. Permissions：**Contents: Read and write**、**Actions: Read and write**
4. 生成后推送时用户名填 GitHub 用户名、密码填 token：
   ```powershell
   git push https://<用户名>:<token>@github.com/KGAafk/<仓库名>.git main
   ```

> ⚠️ **本机特有的坑**：全局 git 代理指向 `127.0.0.1:7897`，而 Clash 平时没开。
> 所有 git 命令必须显式清掉代理，否则报 `Failed to connect to github.com:443 over proxy`：
> ```powershell
> git -c http.proxy= -c https.proxy= push
> ```

---

## 三、工作流文件（仓库里的 `.github/workflows/build.yml`）

当前内容（已能正常出包）：

```yaml
name: build

on:
  workflow_dispatch:        # 允许在网页上手动点按钮触发
  push:
    branches: [ main, master ]

jobs:
  build:
    runs-on: windows-2022

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup MSVC (x86)
        uses: ilammy/msvc-dev-cmd@v1
        with:
          arch: x86            # 必须 x86：游戏是 32 位，产出 DLL 的 PE Machine 必须是 0x14C

      - name: Configure
        run: cmake -S . -B build -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release

      - name: Build
        run: cmake --build build

      - name: Package module
        shell: pwsh
        run: |
          New-Item -ItemType Directory -Force -Path pkg/GuardGauge | Out-Null
          Copy-Item build/GuardGauge.dll pkg/GuardGauge/
          Copy-Item mod.json pkg/GuardGauge/
          Copy-Item README.md pkg/GuardGauge/ -ErrorAction SilentlyContinue

          New-Item -ItemType Directory -Force -Path pkg/BossMode | Out-Null
          Copy-Item build/BossMode.dll pkg/BossMode/
          Copy-Item mod.boss.json pkg/BossMode/mod.json
          Copy-Item BossMode.ini pkg/BossMode/
          Get-ChildItem -Recurse pkg | Select-Object FullName, Length

      - name: Upload modules
        uses: actions/upload-artifact@v4
        with:
          name: soku-mods
          path: pkg
```

关键点说明：

| 行 | 为什么必须这样 |
|---|---|
| `runs-on: windows-2022` | 需要 Windows + MSVC + NMake |
| `arch: x86` | 产出 32 位 DLL；x64 的 DLL 游戏根本不会加载 |
| `-G "NMake Makefiles"` | 无需 Visual Studio IDE，用 MSVC 命令行工具链即可 |
| `CMAKE_BUILD_TYPE=Release` | Debug 版依赖调试 CRT，加载会崩 |
| `upload-artifact` 的 `path: pkg` | 保持 `pkg/模块名/文件` 的目录结构，解压后可直接被 deploy 脚本识别 |

---

## 四、日常流程（改一次代码 → 拿到可用的 DLL）

### 第 1 步：本地提交并推送

```powershell
cd "C:\Users\29287\Documents\deepseek-harness\default-workspace\soku-mod"
git -c user.name=SokuModDev -c user.email=dev@local add -A
git -c user.name=SokuModDev -c user.email=dev@local commit -m "说明这次改了什么"
git -c http.proxy= -c https.proxy= push
```

推上去之后 **Actions 自动开始跑**，约 2–4 分钟。

### 第 2 步：确认构建结果

浏览器打开：`https://github.com/KGAafk/codex-test/actions`

- 绿勾 ✅ = 成功，进第 3 步
- 红叉 ❌ = 编译失败，进第 5 步看日志

也可以手动触发（不推代码时）：Actions → 左侧 `build` → 右侧 **Run workflow** → Run。

### 第 3 步：下载产物

网页方式：点进那次 run → 页面底部 **Artifacts** → 下载 `soku-mods.zip` → 解压，得到：

```
soku-mods/
├── BossMode/   (BossMode.dll, BossMode.ini, mod.json)
└── GuardGauge/ (GuardGauge.dll, mod.json, README.md)
```

### 第 4 步：装进游戏

**先关掉游戏**（DLL 被占用时会替换失败）：

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Users\29287\Documents\deepseek-harness\default-workspace\soku-mod\deploy.ps1" -Source "<soku-mods 解压目录>"
```

脚本会自动：建 `th123\modules\<模块名>\`、复制文件、备份并改写 `ModLoaderSettings.json`。

### 第 5 步：编译失败怎么排查

网页上点开失败的 job → 展开红色步骤，看 `error C....`。

**命令行拉日志**（更适合让 AI 自动处理）：

```bash
# 1) 查最近一次 run 的 id
curl -s "https://api.github.com/repos/KGAafk/codex-test/actions/runs?per_page=3" \
  | python -c "import sys,json;d=json.load(sys.stdin);[print(r['id'],r['status'],r['conclusion'],r['head_sha'][:7]) for r in d['workflow_runs']]"

# 2) 拉日志压缩包（需要 token）
curl -L -H "Authorization: Bearer <TOKEN>" \
  "https://api.github.com/repos/KGAafk/codex-test/actions/runs/<RUN_ID>/logs" -o logs.zip
unzip -o logs.zip -d logs && grep -rn "error" logs/*/5_Build.txt
```

---

## 五、用 API 全自动取产物（不点网页）

```bash
TOKEN=<有 actions:read 的 token>
REPO=KGAafk/codex-test
RUN=<run_id>

# 1) 列出该 run 的 artifacts，拿 id
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/$REPO/actions/runs/$RUN/artifacts" \
  | python -c "import sys,json;[print(a['id'],a['name'],a['size_in_bytes']) for a in json.load(sys.stdin)['artifacts']]"

# 2) 下载 zip（-L 跟随 302 到对象存储）
curl -L -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/$REPO/actions/runs/$RUN/artifacts/<ARTIFACT_ID>/zip" -o soku-mods.zip

unzip -o soku-mod.zip -d soku-mods
```

> 产物默认保留 **90 天**，过期后需要重新跑一次构建。

---

## 六、给新 mod 加编译目标

### 6.1 CMakeLists.txt 追加

```cmake
add_library(
        MyMod
        MODULE
        src_mymod/main.cpp
        src_mymod/version.rc
)
target_compile_options(MyMod PRIVATE /Zi)
target_compile_definitions(MyMod PRIVATE DIRECTINPUT_VERSION=0x0800 CURL_STATICLIB _CRT_SECURE_NO_WARNINGS $<$<CONFIG:Debug>:_DEBUG>)
target_include_directories(MyMod PRIVATE include SokuLib/directx)
target_link_directories(MyMod PRIVATE lib)
target_link_libraries(MyMod SokuLib shlwapi d3d9 d3dx9)
install(TARGETS MyMod DESTINATION .)
```

> `version.rc` 不是必需的，但建议从 `src/version.rc` 复制一份并改掉里面的名字，否则 DLL 属性里还写着 GuardGauge。

### 6.2 工作流打包步骤追加

```powershell
New-Item -ItemType Directory -Force -Path pkg/MyMod | Out-Null
Copy-Item build/MyMod.dll pkg/MyMod/
Copy-Item mod.mymod.json pkg/MyMod/mod.json
Copy-Item MyMod.ini pkg/MyMod/
```

### 6.3 mod.json 最小字段

```json
{
  "name": "MyMod",
  "author": "local dev",
  "priority": "0",
  "description": "一句话说明",
  "version": "0.1.0",
  "main": "MyMod.dll",
  "configFiles": []
}
```

---

## 七、AHK 脚本（不参与上面的编译）

`.ahk` 是解释执行的，**不需要编译**，双击由 AutoHotkey 运行。

- 本机装的是 **AutoHotkey v2.0.26**，但我们的脚本是 **v1 语法**（`Send {d down}`）
- v1 解释器在 `D:\hotkey\v1.1.37.02\AutoHotkeyU64.exe`
- 文件里写了 `#Requires AutoHotkey v1.1`，AHK UX 启动器会自动选 v1
- **必须存成 UTF-8 带 BOM + CRLF**，否则中文乱码

如果想把 `.ahk` 编译成独立 exe（不依赖装 AHK）：
```powershell
& "D:\hotkey\Compiler\Ahk2Exe.exe" /in "脚本.ahk" /out "脚本.exe" /base "D:\hotkey\v1.1.37.02\AutoHotkeyU64.exe"
```
这一步**不需要** GitHub，在本地就能做。

---

## 八、成本与限制

| 项 | 说明 |
|---|---|
| 公共仓库 Actions 时长 | 免费，不限分钟数 |
| 私有仓库 | 每月 2000 分钟免费（Windows runner 按 2 倍计费） |
| 单次构建耗时 | 2–4 分钟（冷启动首次更慢） |
| artifact 保留 | 默认 90 天 |
| 并发 | 免费账户同时 20 个 job 上限 |

---

## 九、常见报错对照

| 现象 | 原因 | 解决 |
|---|---|---|
| `Failed to connect to github.com:443 over proxy` | 全局 git 代理指向已关闭的 7897 | 命令加 `-c http.proxy= -c https.proxy=` |
| `error C2039: 'X': is not a member of 'Y'` | SokuLib 字段名/命名空间写错 | 查 `SokuLib/src/*.hpp` 里的真实定义 |
| `error C2589: '(' : illegal token on right side of '::'` | `std::min/max` 被 windows.h 宏替换 | 顶部 `#define NOMINMAX`，并写 `(std::min)(a,b)` |
| 链接期 `LNK1104: 无法打开文件 d3d9.lib` | `lib/*.lib` 被 .gitignore 排除没提交 | `.gitignore` 里加 `!lib/*.lib` 后 `git add -f lib/*.lib` |
| DLL 加载后游戏无反应 | 编译成了 x64 | 检查 workflow 的 `arch: x86`，用 PE 头验证 `Machine = 0x14C` |
| `CheckVersion` 返回 false | 游戏版本不是 1.10a | `th123.exe` 的 MD5 必须等于 `DF35D1FBC7B583317ADABE8CD9F53B2E` |
| 编译成功但游戏里没效果 | mod 未启用 / 没放对目录 | 查 `ModLoaderSettings.json` 里 `modules/<名字>/<名字>.dll` 的 `enabled` |
| 替换 DLL 报"文件正由另一进程使用" | 游戏还在运行 | 关掉 `th123.exe` 再装 |

---

## 十、一页速查

```powershell
# 1. 改完代码，推
cd "C:\Users\29287\Documents\deepseek-harness\default-workspace\soku-mod"
git -c user.name=SokuModDev -c user.email=dev@local add -A
git -c user.name=SokuModDev -c user.email=dev@local commit -m "update"
git -c http.proxy= -c https.proxy= push

# 2. 等 2-4 分钟，网页下载 artifact：
#    https://github.com/KGAafk/codex-test/actions

# 3. 关游戏，装
powershell -ExecutionPolicy Bypass -File .\deploy.ps1 -Source "<解压目录>"

# 4. 启动游戏，主菜单按 D 确认 mod 已启用
```
