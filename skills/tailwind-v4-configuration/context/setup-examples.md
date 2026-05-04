# Tailwind v4 Setup & Configuration Examples

Detailed code examples for Tailwind CSS v4 installation and configuration.

## Installation Options

### Vite (Recommended)

```bash
npm install tailwindcss@latest @tailwindcss/vite@latest
```

```typescript
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [tailwindcss()],
});
```

```css
@import "tailwindcss";

@theme {
  /* Your theme customization here */
}
```

### PostCSS

```bash
npm install tailwindcss@latest @tailwindcss/postcss@latest
```

```javascript
export default {
  plugins: {
    "@tailwindcss/postcss": {},
  },
};
```

### Standalone CLI

```bash
npm install @tailwindcss/cli@latest
npx @tailwindcss/cli -i ./src/input.css -o ./dist/output.css
```

## CSS-First Theme Configuration

```css
@import "tailwindcss";

@theme {
  /* Custom colors - creates utilities and CSS variables */
  --color-brand-primary: oklch(0.65 0.24 354.31);
  --color-brand-secondary: oklch(0.72 0.11 178);
  --color-accent: #f59e0b;

  /* Color palettes (generates 50-950 scale) */
  --color-neon-pink: oklch(71.7% 0.25 360);
  --color-neon-lime: oklch(91.5% 0.258 129);
  --color-neon-cyan: oklch(91.3% 0.139 195.8);

  /* Custom fonts */
  --font-display: "Satoshi", "sans-serif";
  --font-body: "Inter", sans-serif;
  --font-mono: "JetBrains Mono", monospace;

  /* Custom breakpoints */
  --breakpoint-3xl: 1920px;
  --breakpoint-4xl: 2560px;

  /* Custom spacing */
  --spacing-18: 4.5rem;
  --spacing-128: 32rem;

  /* Custom shadows */
  --shadow-soft: 0 2px 15px -3px rgb(0 0 0 / 0.07);
  --shadow-glow: 0 0 20px rgb(59 130 246 / 0.5);

  /* Custom border radius */
  --radius-button: 0.5rem;
  --radius-card: 0.75rem;

  /* Custom animations */
  --animate-fade-in: fade-in 0.5s ease-out;
  --animate-slide-up: slide-up 0.3s ease-out;

  /* Custom easing functions */
  --ease-fluid: cubic-bezier(0.3, 0, 0, 1);
  --ease-snappy: cubic-bezier(0.2, 0, 0, 1);

  /* Custom transition durations */
  --duration-slow: 500ms;
  --duration-fast: 150ms;
}

@keyframes fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slide-up {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

### Theme Naming Convention

```css
@theme {
  /* Format: --<category>-<name>: <value> */

  /* Colors: --color-<name> */
  --color-primary: #3b82f6;
  --color-secondary: #64748b;

  /* Fonts: --font-<name> */
  --font-sans: "Inter", sans-serif;

  /* Breakpoints: --breakpoint-<name> */
  --breakpoint-xl: 1280px;

  /* Spacing: --spacing-<number> or --spacing-<name> */
  --spacing-72: 18rem;
}
```

## Global Configuration Options

### Prefix Utility Classes

```css
@import "tailwindcss" prefix(tw);

@theme {
  --color-brand: #3b82f6;
}
```

```html
<div class="tw-bg-brand tw-text-center">Prefixed</div>
```

### Important Modifier

```css
@import "tailwindcss" important;
```

### Dark Mode Configuration

```css
@import "tailwindcss";

@custom-variant dark (&:where(.dark, .dark *));

@theme {
  --color-primary: oklch(0.65 0.24 354.31);
  --color-primary-dark: oklch(0.75 0.2 354.31);
}
```

```html
<html class="dark">
  <body class="bg-white dark:bg-gray-900">
    <div class="text-gray-900 dark:text-white">Adapts to dark mode</div>
  </body>
</html>
```

## Content Path Configuration

### Explicit Source Registration

```css
@import "tailwindcss" source(none);

@source "./src/components";
@source "./src/pages";
@source "../shared/ui";
```

### Ignore Specific Paths

```css
@source "./src/components";
@source not "./src/legacy";
@source not "./node_modules";
```

### Safelist Utilities

```css
@import "tailwindcss";

@source inline("bg-blue-500");
@source inline("text-center");
@source inline("hover:opacity-100");
```

## Custom Utilities

### Define Custom Utilities

```css
@import "tailwindcss";

/* Simple utility */
@utility content-auto {
  content-visibility: auto;
}

/* Utility with variants */
@utility text-balance {
  text-wrap: balance;
}

/* Functional utility pattern */
@utility tab-* {
  tab-size: --value(--tab-size-*);
}

@theme {
  --tab-size-2: 2;
  --tab-size-4: 4;
  --tab-size-8: 8;
}
```

### Custom Variants

```css
@import "tailwindcss";

@custom-variant theme-midnight (&:where([data-theme="midnight"] *));
@custom-variant selected-not-disabled (&[data-selected]:not([data-disabled]));
@custom-variant group-hover (&:where(.group:hover *));
@custom-variant landscape (&@(orientation: landscape));
```

```html
<div data-theme="midnight">
  <div class="theme-midnight:bg-gray-900">
    Only applies when data-theme="midnight"
  </div>
</div>

<button data-selected="true" class="selected-not-disabled:bg-blue-500">
  Selected and not disabled
</button>
```

### Apply Variants in Custom CSS

```css
.my-element {
  background: white;

  @variant dark {
    background: black;
  }

  @variant hover {
    background: gray;
  }

  @variant focus {
    outline: 2px solid blue;
  }
}
```

### Component-Like Utilities

```css
@utility btn-base {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  font-weight: 500;
  transition: all 0.2s;
}

@utility btn-primary {
  @utility btn-base;
  background-color: var(--color-blue-500);
  color: white;
}

@utility btn-primary:hover {
  background-color: var(--color-blue-600);
}
```

## Plugin System

### Loading Legacy Plugins

```css
@import "tailwindcss";

@plugin "@tailwindcss/typography";
@plugin "@tailwindcss/forms";
@plugin "@tailwindcss/aspect-ratio";
@plugin "./plugins/my-custom-plugin.js";
```

### Loading Legacy Configuration

```css
@import "tailwindcss";

@config "../../tailwind.config.js";

@theme {
  --color-brand: oklch(0.65 0.24 354.31);
}
```

### Creating Custom Plugins (v4 Style)

```javascript
export default function ({ addUtilities, addComponents, theme }) {
  const newUtilities = {
    ".scrollbar-hide": {
      "-ms-overflow-style": "none",
      "scrollbar-width": "none",
      "&::-webkit-scrollbar": {
        display: "none",
      },
    },
  };

  addUtilities(newUtilities);
}
```

```css
@plugin "./plugins/my-plugin.js";
```

## Common Issues & Solutions

### Classes Not Generating

```css
@import "tailwindcss" source(none);
@source "./src";
@source "./components";
```

### Variants Not Working

```css
/* ✅ Correct - custom variant */
@custom-variant dark (&:where(.dark, .dark *));

/* ❌ Wrong - don't use @layer for variants */
@layer components {
  .dark-mode {
    @variant dark {
      /* This won't work as expected */
    }
  }
}
```

### Legacy Plugin Not Loading

```css
/* ✅ Correct */
@plugin "@tailwindcss/typography";

/* ❌ Wrong */
@layer components {
  @import "@tailwindcss/typography";
}
```