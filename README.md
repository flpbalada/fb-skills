# Skills

Personal skill library for AI coding agents, built from my second brain.

I maintain a personal collection of notes on programming patterns, product management frameworks, and psychology principles. This repo turns those notes into executable AI skills, making accumulated knowledge actionable during coding sessions.

## Install

from repo:
`npx skills add flpbalada/fb-skills`

all from repo:
`npx skills add flpbalada/fb-skills --all`

## Demo Site

Local Astro demo for browsing skills in `./skills`.

```bash
pnpm install
pnpm dev
```

Build static site:

```bash
pnpm build
pnpm preview
```

The demo reads `skills/*/SKILL.md` at build time. It lets you browse skills and copy a skill name, path, or full `SKILL.md` content.

Install remains manual. Use `skills.sh` with this repo, a copied local path, or copied content. Exact `skills.sh` flags vary by installed version, so check its help before running install commands.
