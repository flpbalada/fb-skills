---
name: tailwind-v4-configuration
description: Configure Tailwind CSS v4 with the CSS-first setup. Use when installing Tailwind v4, migrating from v3, setting up Vite, PostCSS, CLI, or framework integration, defining @theme tokens, using @source, configuring plugins, debugging content detection, or checking browser support. For component-level utilities, variants, CVA, or tailwind-variants use code-architecture-tailwind-v4-best-practices.
---

# Tailwind CSS v4 Configuration

## When to use

- Installing or configuring Tailwind CSS v4.
- Migrating from Tailwind v3.
- Setting up Vite, PostCSS, CLI, or framework integration.
- Defining tokens with `@theme`.
- Configuring plugins or utility changes.
- Debugging v4 config issues.

## Goal

Use Tailwind v4's CSS-first configuration.
Keep JavaScript config only when project tooling requires it.

## Rules

- Import Tailwind with `@import "tailwindcss";`.
- Define theme tokens with `@theme`.
- Rely on automatic content detection by default.
- Use `@source` only for missed files or external packages.
- Use CSS custom properties for theme values.
- Check browser support before using v4 in legacy environments.
- Do not copy v3 `content` config unless needed.
- Do not use old `@tailwind base/components/utilities` in v4 setup.

## Pattern

```css
@import "tailwindcss";

@theme {
  --color-brand-primary: oklch(0.65 0.24 354.31);
  --font-display: "Satoshi", "sans-serif";
  --breakpoint-3xl: 1920px;
}
```

## Key Changes

- CSS-first config.
- Single import.
- Automatic content detection.
- Native cascade layers.
- Theme values as CSS variables.
- Modern browser baseline.

## Utility Changes

- `shadow-sm` (v3) → `shadow-xs` (v4)
- `rounded-sm` (v3) → `rounded-xs` (v4)
- `bg-gradient-to-r` (v3) → `bg-linear-to-r` (v4)

## Flow

1. Identify project framework and build tool.
2. Check existing Tailwind version.
3. Add v4 package and integration.
4. Create or update main CSS entry.
5. Move tokens into `@theme`.
6. Add `@source` only when detection misses files.
7. Run build and visual check.

## Browser Compatibility

- Chrome/Edge 111+
- Firefox 128+
- Safari 16.4+

## References

- `context/setup-examples.md`: installation and CSS config.
- `context/migration-guide.md`: v3 to v4 migration.
- `context/framework-examples.md`: framework setup.
- `context/advanced-config.md`: advanced config.
- [Tailwind CSS v4 Documentation](https://tailwindcss.com/docs)
- [Tailwind CSS v4 Upgrade Guide](https://tailwindcss.com/docs/upgrade-guide)
- [Automatic Upgrade Tool](https://github.com/tailwindlabs/upgrade)

## Output

- Install or migration steps.
- Main CSS config.
- Build tool change.
- Verification command.
