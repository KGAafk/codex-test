<#
.SYNOPSIS
    把编译好的 GuardGauge.dll 装进非想天则，并注册到 ModLoaderSettings.json。

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\deploy.ps1
    powershell -ExecutionPolicy Bypass -File .\deploy.ps1 -Dll "D:\下载\GuardGauge.dll"
#>
param(
    [string]$GameRoot = 'D:\touhou\【完整包】非想天则整合包2026-10-18',
    [string]$Dll = (Join-Path $PSScriptRoot 'build\GuardGauge.dll'),
    [string]$ModuleName = 'GuardGauge'
)

$ErrorActionPreference = 'Stop'

$th123 = Join-Path $GameRoot 'th123'
$modDir = Join-Path $th123 ('modules\' + $ModuleName)
$cfgPath = Join-Path $th123 'ModLoaderSettings.json'

if (-not (Test-Path $th123)) {
    throw "找不到游戏目录: $th123"
}
if (-not (Test-Path $Dll)) {
    throw "找不到 DLL: $Dll （先编译，或用 -Dll 指定路径）"
}

# 1) 放 dll 和 mod.json
New-Item -ItemType Directory -Force -Path $modDir | Out-Null
Copy-Item $Dll (Join-Path $modDir ($ModuleName + '.dll')) -Force
$modJson = Join-Path $PSScriptRoot 'mod.json'
if (Test-Path $modJson) {
    Copy-Item $modJson (Join-Path $modDir 'mod.json') -Force
} else {
    @{
        name        = $ModuleName
        author      = 'local dev'
        priority    = '0'
        description = '破防槽 mod'
        version     = '0.1.0'
        main        = ($ModuleName + '.dll')
        configFiles = @()
    } | ConvertTo-Json -Depth 4 | Set-Content (Join-Path $modDir 'mod.json') -Encoding UTF8
}

# 2) 备份配置
if (Test-Path $cfgPath) {
    $backup = $cfgPath + '.bak-' + (Get-Date -Format 'yyyyMMdd-HHmmss')
    Copy-Item $cfgPath $backup -Force
    Write-Host "已备份配置 -> $backup"
    $cfg = Get-Content $cfgPath -Raw -Encoding UTF8 | ConvertFrom-Json
} else {
    $cfg = [pscustomobject]@{ modules = [pscustomobject]@{} }
    Write-Host "配置不存在，将新建"
}

if (-not $cfg.modules) {
    $cfg | Add-Member -NotePropertyName modules -NotePropertyValue ([pscustomobject]@{}) -Force
}

# 3) 注册模块（JSON 结构里 modules 是"路径 -> 配置"的字典）
$key = "modules/$ModuleName/$ModuleName.dll"
$entry = [pscustomobject]@{ enabled = $true; priority = 0 }

$existing = $cfg.modules.PSObject.Properties[$key]
if ($existing) {
    $existing.Value.enabled = $true
    Write-Host "模块已存在，已设为启用: $key"
} else {
    $cfg.modules | Add-Member -NotePropertyName $key -NotePropertyValue $entry -Force
    Write-Host "已注册模块: $key"
}

$cfg | ConvertTo-Json -Depth 8 -Compress | Set-Content $cfgPath -Encoding UTF8 -NoNewline

Write-Host ""
Write-Host "完成。文件位置:" -ForegroundColor Green
Get-ChildItem $modDir | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
Write-Host "启动游戏后，主菜单按 D 可以确认 GuardGauge 已启用。"
