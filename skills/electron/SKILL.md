---
name: electron
description: Automate or test Electron desktop apps through agent-browser and Chrome DevTools Protocol, including Slack, VS Code, Discord, Figma, Notion, Spotify, and similar apps. Use when user asks to control, connect to, inspect, click, fill, screenshot, or interact with a native Electron app UI. Do not use for normal web URLs.
allowed-tools: Bash(agent-browser:*), Bash(npx agent-browser:*)
---

# Electron App Automation

Control Electron desktop apps with `agent-browser` through Chrome DevTools Protocol.

## When to use

- User asks to automate or test an Electron app.
- App is Slack, VS Code, Discord, Figma, Notion, Spotify, or similar.
- Task needs desktop app interaction through UI.

## Goal

- Launch app with remote debugging.
- Connect `agent-browser`.
- Use snapshots to find refs.
- Interact with the app like a user.

## Rules

- App must be launched with `--remote-debugging-port`.
- If app is already running, quit and relaunch with flag.
- Prefer unique ports for multiple apps.
- Use named sessions when controlling multiple apps.
- Use `snapshot -i` before clicking or filling.
- Re-snapshot after navigation or state changes.

## Flow

1. Launch app with CDP port.
2. Wait for app to start.
3. Connect `agent-browser`.
4. List tabs when multiple windows or webviews exist.
5. Snapshot and interact.
6. Capture screenshots or data as needed.

## Launch examples

```bash
open -a "Slack" --args --remote-debugging-port=9222
open -a "Visual Studio Code" --args --remote-debugging-port=9223
open -a "Discord" --args --remote-debugging-port=9224
open -a "Figma" --args --remote-debugging-port=9225
open -a "Notion" --args --remote-debugging-port=9226
open -a "Spotify" --args --remote-debugging-port=9227
```

Linux:

```bash
slack --remote-debugging-port=9222
code --remote-debugging-port=9223
discord --remote-debugging-port=9224
```

Windows:

```bash
"C:\Users\%USERNAME%\AppData\Local\slack\slack.exe" --remote-debugging-port=9222
"C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\Code.exe" --remote-debugging-port=9223
```

## Connect

```bash
agent-browser connect 9222
agent-browser snapshot -i
agent-browser click @e5
agent-browser screenshot app.png
```

Use per-command CDP when needed:

```bash
agent-browser --cdp 9222 snapshot -i
```

## Tabs and webviews

```bash
agent-browser tab
agent-browser tab 2
agent-browser tab --url "*settings*"
```

Webviews appear as separate targets.
Switch to the right target before interacting.

## Multiple apps

```bash
agent-browser --session slack connect 9222
agent-browser --session vscode connect 9223
agent-browser --session slack snapshot -i
agent-browser --session vscode snapshot -i
```

## Troubleshooting

- Connection refused: relaunch app with CDP flag.
- Wrong window: run `agent-browser tab`.
- Elements missing: switch tab or webview.
- App slow to appear: wait a few seconds, then snapshot again.
- Dark mode lost: use `agent-browser --color-scheme dark ...`.
