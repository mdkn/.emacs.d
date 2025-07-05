# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Emacs configuration directory (.emacs.d) that uses the `leaf` package manager for configuration. The setup includes Japanese input support with SKK and a custom daily report system.

## Key Configuration Structure

- **`init.el`**: Main configuration file containing all package configurations and custom functions
- **`early-init.el`**: Early initialization that disables GUI elements (menu bar, tool bar)
- **`elpa/`**: Package directory managed by Emacs Package Manager

## Core Features

### Package Management
- Uses `leaf` package manager with `leaf-keywords` for configuration
- Packages are installed from GNU ELPA and MELPA repositories
- Package initialization occurs at startup via `package-initialize`

### Japanese Input (SKK)
- Configured with `ddskk` package for Japanese input
- Default input method set to "japanese-skk"
- Includes `ddskk-posframe` for enhanced UI
- Key bindings:
  - `C-x C-j`: Toggle SKK mode
  - `C-x j`: SKK auto-fill mode
  - `C-x t`: SKK tutorial

### Daily Report System
- Custom functions for managing daily reports in Org mode
- Reports stored in `~/src/org/daily-reports/`
- Key bindings:
  - `F9`: Create new daily report (`create-daily-report`)
  - `F8`: List all daily reports (`list-daily-reports`)
- Report files named with timestamp format: `YYYY-MM-DD_HH-MM-SS.org`
- Template includes sections for Summary, Tasks, and Notes

### Key Bindings
- `C-h`: Delete backward character (overrides default help)
- `C-t`: Mapped to `ctl-x-map` (replaces default transpose)
- `C-t C-t`: Switch between windows (`other-window`)

### File Management
- Auto-save enabled with 1-second interval
- Backup files stored in `~/.emacs.d/backup/`
- Version control enabled for backups with automatic cleanup

### Org Mode Configuration
- Startup truncation disabled
- Fill column set to 10000 (essentially unlimited)
- Auto-fill mode disabled, visual-line-mode enabled
- Optimized for long-form writing

## Development Commands

Since this is an Emacs configuration, development primarily involves:

1. **Testing configuration changes**: Restart Emacs or use `M-x eval-buffer` in init.el
2. **Package management**: Use `M-x package-install` or add to `package-selected-packages`
3. **Byte compilation**: Emacs automatically compiles .el files to .elc for performance

## Daily Report Workflow

1. Press `F9` to create a new daily report
2. Press `F8` to browse existing reports
3. In the report list, press `RET` to open a report or `q` to quit
4. Reports are automatically saved in the designated directory with timestamp filenames