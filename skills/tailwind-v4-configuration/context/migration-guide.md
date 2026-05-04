# Tailwind v3 to v4 Migration Guide

Complete guide for migrating from Tailwind CSS v3 to v4.

## Automated Migration

```bash
npx @tailwindcss/upgrade
```

The tool handles:
- Updating dependencies
- Migrating `tailwind.config.js` to CSS `@theme`
- Updating template files for breaking changes
- Modifying PostCSS configuration

## Manual Migration Steps

### 1. Update Dependencies

```bash
# Remove v3
npm uninstall tailwindcss postcss autoprefixer

# Install v4
npm install tailwindcss @tailwindcss/vite @tailwindcss/postcss
```

### 2. Update PostCSS Config

```javascript
// v3
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
    postcss-import: {},
  },
};

// v4
export default {
  plugins: {
    "@tailwindcss/postcss": {},
  },
};
```

### 3. Replace CSS Imports

```css
/* v3 */
@tailwind base;
@tailwind components;
@tailwind utilities;

/* v4 */
@import "tailwindcss";
```

### 4. Migrate JavaScript Config to CSS

```javascript
// tailwind.config.js (v3)
module.exports = {
  theme: {
    extend: {
      colors: {
        brand: "#3b82f6",
        mint: "#10b981",
      },
      fontFamily: {
        display: ["Satoshi", "sans-serif"],
      },
      screens: {
        "3xl": "1920px",
      },
    },
  },
};
```

```css
/* app.css (v4) */
@import "tailwindcss";

@theme {
  --color-brand: #3b82f6;
  --color-mint: #10b981;
  --font-display: "Satoshi", "sans-serif";
  --breakpoint-3xl: 1920px;
}
```

### 5. Breaking Utility Changes

#### Shadow Utilities

```html
<!-- v3 -->
<input class="shadow-sm" />

<!-- v4 -->
<input class="shadow-xs" />

<!-- v3 -->
<input class="shadow" />

<!-- v4 -->
<input class="shadow-sm" />
```

#### Border Radius Utilities

```html
<!-- v3 -->
<input class="rounded-sm" />

<!-- v4 -->
<input class="rounded-xs" />
```

#### Blur Utilities

```html
<!-- v3 -->
<div class="blur-sm" />

<!-- v4 -->
<div class="blur-xs" />

<!-- v3 -->
<div class="blur" />

<!-- v4 -->
<div class="blur-sm" />
```

#### Outline Utilities

```html
<!-- v3 (removed outline) -->
<input class="focus:outline-none" />

<!-- v4 (equivalent) -->
<input class="focus:outline-hidden" />

<!-- v4 (outline-style: none) -->
<input class="focus:outline-none" />
```

#### Opacity Utilities

```html
<!-- v3 -->
<div class="bg-blue-500 bg-opacity-50" />

<!-- v4 -->
<div class="bg-blue-500/50" />
```

#### Gradients

```html
<!-- v3 -->
<div class="bg-gradient-to-r from-blue-500 to-purple-500" />

<!-- v4 -->
<div class="bg-linear-to-r from-blue-500 to-purple-500" />
```

#### Border Color

```html
<!-- v3 (default gray-200) -->
<div class="border border-gray-200" />

<!-- v4 (default currentColor) -->
<div class="border border-current" />

<!-- v4 (explicitly set) -->
<div class="border border-gray-200" />
```

#### Ring Utilities

```html
<!-- v3 (3px blue-500) -->
<div class="ring" />

<!-- v4 (3px currentColor) -->
<div class="ring-3" />

<!-- v4 (explicit color) -->
<div class="ring-3 ring-blue-500" />
```

### Content Configuration Migration

```javascript
// v3 - required
module.exports = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
};
```

```css
/* v4 - automatic! (respects .gitignore) */
@import "tailwindcss";

/* Only configure if you need to override */
@import "tailwindcss" source(none);
@source "./src";
```

### Plugin Migration

```javascript
// v3
module.exports = {
  plugins: [require("@tailwindcss/typography"), require("@tailwindcss/forms")],
};
```

```css
/* v4 */
@import "tailwindcss";

@plugin "@tailwindcss/typography";
@plugin "@tailwindcss/forms";
```

## Key v4 Changes Overview

| Aspect             | v3                                | v4                                              |
| ------------------ | --------------------------------- | ----------------------------------------------- |
| **Configuration**  | `tailwind.config.js` (JavaScript) | `@theme` block in CSS                           |
| **Import**         | Three `@tailwind` directives      | Single `@import "tailwindcss"`                  |
| **Content paths** | Explicit `content` array          | Automatic detection (respects `.gitignore`)     |
| **Build pipeline** | Requires PostCSS + plugins        | Integrated Lightning CSS (all-in-one)           |
| **Performance**    | Fast                              | 10x faster (Oxide engine)                       |
| **Colors**         | hex, rgb, hsl                     | Native `oklch()` + modern color spaces          |
| **Variants**       | `outline-none` removed outline    | `outline-hidden` + proper `outline-none`        |
| **Shadows**        | `shadow-sm` (smallest)            | `shadow-xs` (smallest), `shadow-md` (default)   |
| **Border radius**  | `rounded-sm` (smallest)           | `rounded-xs` (smallest), `rounded-md` (default) |