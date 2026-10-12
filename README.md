# TikTok NumPad Scroll Bridge

A local AutoHotkey-to-Chrome bridge for scrolling TikTok without taking focus from the current window.

## Requirements

- Windows
- AutoHotkey v2
- Node.js 18 or newer
- Chrome 116 or newer, with TikTok open in the same browser profile as the extension

## Setup

1. Extract the release ZIP.
2. Run `setup.ps1` from PowerShell. It generates a private per-installation token and writes runnable files into `runtime/`.
3. In Chrome, open `chrome://extensions`, enable Developer mode, and select **Load unpacked** → `runtime/extension`.
4. Run `runtime/tiktok_numpad.ahk`.

The AHK script starts the local Node server automatically. Keep the extension loaded and a TikTok tab open.

## Keys

- Numpad 6: scroll up (previous item)
- Numpad 3: scroll down (next item)
- With NumLock off, Numpad Right and Numpad Page Down provide the same actions.

The extension scrolls the most recently accessed TikTok tab in that browser profile; it does not activate or focus Chrome.

## Local data

`setup.ps1` creates a random token and places it only in ignored `runtime/` files. Do not commit or share `runtime/`.
