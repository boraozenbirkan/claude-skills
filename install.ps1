<#
.SYNOPSIS
  Install this repo's skills into ~/.claude/skills.

.DESCRIPTION
  Links each skill under skills/ into the personal skills directory, so edits here take effect
  without reinstalling. Falls back to copying when a link cannot be created.

  Any existing directory at the destination is backed up to <name>.backup-<timestamp> first.

.EXAMPLE
  ./install.ps1
  ./install.ps1 -Name project-foundation
  ./install.ps1 -Copy
#>
param(
  [string]$Name,
  [switch]$Copy
)

$ErrorActionPreference = 'Stop'

$source = Join-Path $PSScriptRoot 'skills'
$target = Join-Path $HOME '.claude/skills'

if (-not (Test-Path $target)) { New-Item -ItemType Directory -Force -Path $target | Out-Null }

$skills = Get-ChildItem -Path $source -Directory
if ($Name) { $skills = $skills | Where-Object { $_.Name -eq $Name } }
if (-not $skills) { throw "No skill found matching '$Name' in $source" }

foreach ($skill in $skills) {
  $dest = Join-Path $target $skill.Name

  if (Test-Path $dest) {
    $stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backup = "$dest.backup-$stamp"
    Move-Item -Path $dest -Destination $backup
    Write-Host "  backed up existing -> $backup" -ForegroundColor DarkGray
  }

  $linked = $false
  if (-not $Copy) {
    # A directory junction needs no elevation, unlike a symlink without Developer Mode.
    cmd /c mklink /J "$dest" "$($skill.FullName)" | Out-Null
    if ($LASTEXITCODE -eq 0) { $linked = $true }
  }

  if ($linked) {
    Write-Host "linked  $($skill.Name)" -ForegroundColor Green
  } else {
    Copy-Item -Path $skill.FullName -Destination $dest -Recurse
    Write-Host "copied  $($skill.Name)" -ForegroundColor Yellow
    Write-Host "  (a copy does not track edits in this repo; re-run to update)" -ForegroundColor DarkGray
  }
}

Write-Host ""
Write-Host "Installed to $target" -ForegroundColor Cyan
Write-Host "Restart Claude Code if it was running when a new skill directory was created."
