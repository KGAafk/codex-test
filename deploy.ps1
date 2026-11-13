<#
.SYNOPSIS
    把编译好的 mod 装进非想天则，并注册到 ModLoaderSettings.json。
    支持单文件 DLL，也支持一个包含若干 mod 文件夹的「产物目录」。

.EXAMPLE
    # 装一个目录里的所有 mod（解压 Actions 产物后）
    powershell -ExecutionPolicy Bypass -File .\deploy.ps1 -Source ".\soku-mods"

.EXAMPLE
    # 只装某个 dll
    powershell -ExecutionPolicy Bypass -File .\deploy.ps1 -Dll "D:\下载\BossMode.dll" -Name BossMode
#>
param(
    [string]$GameRoot = 'D:\touhou\【完整包】非想天则整合包2026-10-18',
    [string]$Source = '',
    [string]$Dll = '',
    [string]$Name = ''
)

$ErrorActionPreference = 'Stop'

$th123 = Join-Path $GameRoot 'th123'
$cfgPath = Join-Path $th123 'ModLoaderSettings.json'

if (-not (Test-Path $th123)) { throw "找不到游戏目录: $th123" }

function Install-Module {
    param([string]$ModuleName, [string]$SourceDir, [string]$DllPath, [string]$IniName)

    $modDir = Join-Path $th123 ('modules\' + $ModuleName)
    New-Item -ItemType Directory -Force -Path $modDir | Out-Null

    if (-not $DllPath) { $DllPath = Join-Path $SourceDir ($ModuleName + '.dll') }
    if (-not (Test-Path $DllPath)) { throw "找不到 DLL: $DllPath" }

    Copy-Item $DllPath (Join-Path $modDir ($ModuleName + '.dll')) -Force
    Write-Host "  放进 $modDir"

    $modJson = Join-Path $SourceDir 'mod.json'
    if (Test-Path $modJson) { Copy-Item $modJson (Join-Path $modDir 'mod.json') -Force }

    foreach ($extra in Get-ChildItem $SourceDir -File -ErrorAction SilentlyContinue) {
        if ($extra.Extension -in '.ini', '.json', '.txt' -and $extra.Name -ne 'mod.json') {
            Copy-Item $extra.FullName (Join-Path $modDir $extra.Name) -Force
        }
    }

    # 注册
    if (Test-Path $cfgPath) {
        $cfg = Get-Content $cfgPath -Raw -Encoding UTF8 | ConvertFrom-Json
    } else {
        $cfg = [pscustomobject]@{ modules = [pscustomobject]@{} }
    }
    if (-not $cfg.modules) {
        $cfg | Add-Member -NotePropertyName modules -NotePropertyValue ([pscustomobject]@{}) -Force
    }

    $key = "modules/$ModuleName/$ModuleName.dll"
    if ($cfg.modules.PSObject.Properties[$key]) {
        $cfg.modules.PSObject.Properties[$key].Value.enabled = $true
        Write-Host "  已启用 $key"
    } else {
        $cfg.modules | Add-Member -NotePropertyName $key -NotePropertyValue ([pscustomobject]@{ enabled = $true; priority = 0 }) -Force
        Write-Host "  已注册 $key"
    }

    $cfg | ConvertTo-Json -Depth 8 -Compress | Set-Content $cfgPath -Encoding UTF8 -NoNewline
}

# 备份配置
if (Test-Path $cfgPath) {
    $backup = $cfgPath + '.bak-' + (Get-Date -Format 'yyyyMMdd-HHmmss')
    Copy-Item $cfgPath $backup -Force
    Write-Host "已备份配置 -> $backup"
}

if ($Dll) {
    $n = if ($Name) { $Name } else { [IO.Path]::GetFileNameWithoutExtension($Dll) }
    Install-Module -ModuleName $n -SourceDir (Split-Path $Dll) -DllPath $Dll
    exit 0
}

if (-not $Source) { throw "请用 -Source <产物目录> 或 -Dll <dll路径> 指定要装的东西" }

# 逐个文件夹安装（每个文件夹 = 一个 mod）
Get-ChildItem $Source -Directory | ForEach-Object {
    Write-Host "== $($_.Name)"
    Install-Module -ModuleName $_.Name -SourceDir $_.FullName
}

Write-Host ""
Write-Host "完成。当前已装模块：" -ForegroundColor Green
(Get-Content $cfgPath -Raw -Encoding UTF8 | ConvertFrom-Json).modules.PSObject.Properties |
    Where-Object { $_.Name -like '*GuardGauge*' -or $_.Name -like '*BossMode*' } |
    ForEach-Object { "  $($_.Name)  enabled=$($_.Value.enabled)" }
