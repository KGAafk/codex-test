<#
.SYNOPSIS
    一键切换「神AI 操控哪一边」+「BossMode 强化哪一边」。

.EXAMPLE
    # 神AI 操控 1P，并把 1P 强化成 Boss（你朋友打你的强化 AI）
    powershell -ExecutionPolicy Bypass -File .\switch-mode.ps1 -Mode ai1p -Character 15

.EXAMPLE
    # 恢复成之前那样：神AI 操控 2P，2P 是强化早苗
    powershell -ExecutionPolicy Bypass -File .\switch-mode.ps1 -Mode boss2p -Character 15
#>
param(
    [ValidateSet('ai1p', 'boss2p')]
    [string]$Mode = 'ai1p',
    [int]$Character = 15,
    [string]$AIFolder = 'D:\touhou\神AI\th123ai',
    [string]$GameRoot = 'D:\touhou\【完整包】非想天则整合包2026-10-18'
)

$ErrorActionPreference = 'Stop'
$latin1 = [Text.Encoding]::GetEncoding(28591)

# ---- 1) 找对应角色的 AI 脚本 ----
$prefix = '{0:D2}_' -f $Character
$candidates = Get-ChildItem (Join-Path $AIFolder 'script') -Filter "$prefix*.ai" |
    Where-Object { $_.Name -match '^\d\d_.*_main\.ai$' } |
    Sort-Object Name
if (-not $candidates) { throw "找不到角色 $Character 的 AI 脚本（前缀 $prefix）" }
$scriptName = $candidates[0].Name
Write-Host "AI 脚本: $scriptName"

# ---- 2) 改 th123_ai.ini（Shift-JIS 文件，按字节安全替换 ASCII 行） ----
$aiSide = if ($Mode -eq 'ai1p') { 1 } else { 2 }
$aiIni = Join-Path $AIFolder 'th123_ai.ini'
$txt = $latin1.GetString([IO.File]::ReadAllBytes($aiIni))
$txt = [regex]::Replace($txt, '(?m)^Player=\d+', "Player=$aiSide")
$txt = [regex]::Replace($txt, '(?m)^StartupAI=.*', "StartupAI=script\$scriptName")
[IO.File]::WriteAllBytes($aiIni, $latin1.GetBytes($txt))
Write-Host "th123_ai.ini -> Player=$aiSide, StartupAI=script\$scriptName"

# ---- 3) 改 BossMode.ini（GBK 文件，同样按字节替换） ----
$bossSide = if ($Mode -eq 'ai1p') { 1 } else { 2 }
$bossIni = Join-Path $GameRoot 'th123\modules\BossMode\BossMode.ini'
if (-not (Test-Path $bossIni)) { throw "找不到 $bossIni" }
$txt = $latin1.GetString([IO.File]::ReadAllBytes($bossIni))
$txt = [regex]::Replace($txt, '(?m)^Side=\d+', "Side=$bossSide")
$txt = [regex]::Replace($txt, '(?m)^Character=-?\d+', "Character=$Character")
[IO.File]::WriteAllBytes($bossIni, $latin1.GetBytes($txt))
Write-Host "BossMode.ini -> Side=$bossSide, Character=$Character"

Write-Host ""
if ($Mode -eq 'ai1p') {
    Write-Host "现在：1P = 强化角色 + 神AI 代打；2P = 人类（你朋友）" -ForegroundColor Green
    Write-Host "启动顺序：先开游戏进对局 → 再双击 th123_ai.exe"
} else {
    Write-Host "现在：2P = 强化角色 + 神AI 代打；1P = 人类（你）" -ForegroundColor Green
    Write-Host "启动顺序：先开游戏进对局（2P 选对应角色）→ 再双击 th123_ai.exe"
}
