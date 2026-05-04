---
name: tailwind-v4-configuration
description: Configure Tailwind CSS v4 with CSS-first approach. Use when installing, migrating from v3, setting up build tools (Vite/PostCSS/CLI), customizing themes with @theme, or configuring plugins.
---

# Tailwind CSS v4 Configuration

A complete guide to configuring Tailwind CSS v4 with its new CSS-first approach, unified toolchain, and modern feature set.

## When to Use This Skill

- **Installing Tailwind v4** for the first time in a new project
- **Migrating from Tailwind v3** to v4 (breaking changes and setup differences)
- **Setting up build tools**: Vite, PostCSS, or standalone CLI
- **Customizing themes** using the `@theme` directive
- **Configuring content paths** and template detection
- **Adding plugins** or creating custom utilities
- **Configuring dark mode**, prefixes, or other global options
- **Troubleshooting** v4 configuration issues

## Key v4 Changes Overview

| Aspect             | v3                                | v4                                              |
| ------------------ | --------------------------------- | ----------------------------------------------- |
| **Configuration**  | `tailwind.config.js` (JavaScript) | `@theme` block in CSS                           |
| **Import**         | Three `@tailwind` directives      | Single `@import "tailwindcss"`                  |
| **Content paths**  | Explicit `content` array          | Automatic detection (respects `.gitignore`)     |
| **Build pipeline** | Requires PostCSS + plugins        | Integrated Lightning CSS (all-in-one)           |
| **Performance**    | Fast                              | 10x faster (Oxide engine)                       |
| **Colors**         | hex, rgb, hsl                     | Native `oklch()` + modern color spaces          |
| **Variants**       | `outline-none` removed outline    | `outline-hidden` + proper `outline-none`        |
| **Shadows**        | `shadow-sm` (smallest)            | `shadow-xs` (smallest), `shadow-md` (default)   |
| **Border radius**  | `rounded-sm` (smallest)           | `rounded-xs` (smallest), `rounded-md` (default) |

## Core Concepts

### CSS-First Configuration

All configuration now lives in your CSS file using the `@theme` directive:

```css
@import "tailwindcss";

@theme {
  --color-brand-primary: oklch(0.65 0.24 354.31);
  --font-display: "Satoshi", "sans-serif";
  --breakpoint-3xl: 1920px;
}
```

### Automatic Content Detection

v4 automatically discovers templates - no configuration needed for most projects.

### Key Utility Changes

- `shadow-sm` (v3) → `shadow-xs` (v4)
- `rounded-sm` (v3) → `rounded-xs` (v4)
- `bg-gradient-to-r` (v3) → `bg-linear-to-r` (v4)

## Progressive Disclosure

This skill provides detailed examples through context files. Load them when needed:

| Context File                                    | When to Load                                      |
| ----------------------------------------------- | -------------------------------------------------- |
| `context/setup-examples.md`                     | Setting up installation, CSS config, custom utils  |
| `context/migration-guide.md`                    | Migrating from v3 to v4                            |
| `context/framework-examples.md`                 | Setting up Next.js, React, Vue, SvelteKit          |
| `context/advanced-config.md`                    | Multi-stylesheets, theming, animations            |

## Best Practices

### ✅ DO

- Use `@import "tailwindcss"` with a single import
- Define theme tokens in `@theme` block
- Leverage automatic content detection
- Use CSS variables with `@theme` for dynamic theming
- Use `@utility` for custom utilities (not `@apply` for components)
- Use `@custom-variant` for reusable variant logic
- Test the automated upgrade tool before manual migration

### ❌ DON'T

- Create a `tailwind.config.js` file (use CSS `@theme` instead)
- Use `@tailwind base/components/utilities` separately
- Configure `content` paths unless you have a specific need
- Forget to update breaking utility changes (shadow, blur, radius)
- Use opacity utilities like `bg-opacity-50` (use `/50` instead)
- Ignore browser compatibility (v4 targets modern browsers)
- Try to load legacy `autoprefixer` or `postcss-import`

## Browser Compatibility

Tailwind CSS v4 targets modern browsers:

- **Chrome/Edge:** 111+
- **Firefox:** 128+
- **Safari:** 16.4+

## Quick Decision Guide

```
Need to install Tailwind v4?
├─ New project? → Use Vite plugin (recommended)
├─ Existing project? → Use PostCSS plugin
└─ Static site? → Use CLI

Migrating from v3?
└─ Run: npx @tailwindcss/upgrade

Need custom utilities?
└─ Use @utility directive in CSS

Need framework setup?
└─ See context/framework-examples.md
```

## References

- [Tailwind CSS v4 Documentation](https://tailwindcss.com/docs)
- [Tailwind CSS v4 Upgrade Guide](https://tailwindcss.com/docs/upgrade-guide)
- [Automatic Upgrade Tool](https://github.com/tailwindlabs/upgrade)