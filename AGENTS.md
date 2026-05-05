# AGENTS.md

## Commands

- Use `pnpm`; `package.json` pins `pnpm@9.15.9`.
- Dev server: `pnpm dev`.
- Static build: `pnpm build`; preview with `pnpm preview` after build.
- Lint/format check: `pnpm check` (`biome check .`).
- Auto-fix formatting/lint/imports: `pnpm check:write`; format-only: `pnpm format`.
- No test script exists; use `pnpm check` and `pnpm build` for verification.

## App Shape

- This is an Astro static demo site for browsing the local `skills/*/SKILL.md` library.
- Skill data is read at build/runtime from filesystem code in `src/lib/skills.ts`; pages are in `src/pages`.
- `src/pages/index.astro` lists skills; `src/pages/skills/[slug].astro` renders each `SKILL.md`.
- Extra skill docs under `skills/<slug>/*.md` and one nested level `skills/<slug>/<section>/*.md` are rendered by the two `*.md.astro` dynamic routes.

## Skill Files

- Each skill lives in `skills/<slug>/SKILL.md`.
- Frontmatter fields parsed by the site are simple `name:` and `description:` lines only; complex YAML is not parsed by `src/lib/skills.ts`.
- If frontmatter is missing, the site falls back to the first markdown heading for `name` and first non-heading paragraph for `description`.

## Quirks

- `astro.config.mjs` denies raw Vite filesystem serving for `skills/**`; a dev middleware rewrites `/skills/*.md` requests so Astro routes render markdown pages instead.
- `dist/` is excluded from Biome via `biome.json`; do not edit build output by hand.
- `AGENTS.personal.md` contains user preferences, not repo architecture.
