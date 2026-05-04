# Tailwind v4 Advanced Configuration

Advanced configuration patterns for complex use cases.

## Multiple Tailwind Stylesheets

In v4, you can have multiple Tailwind stylesheets with isolated configurations:

```css
/* admin/styles.css */
@import "tailwindcss" source(none);

@source "../admin";
@source "../shared/admin";

@theme {
  --color-admin-primary: #7c3aed;
}

@utility admin-btn {
  /* Admin-specific button styles */
}
```

```css
/* public/styles.css */
@import "tailwindcss" source(none);

@source "../public";
@source "../shared/public";

@theme {
  --color-public-primary: #3b82f6;
}
```

## Custom Property Scoping

Use CSS custom properties with theme for dynamic theming:

```css
@import "tailwindcss";

@theme {
  --color-background: var(--theme-bg, #ffffff);
  --color-foreground: var(--theme-fg, #0f172a);
  --color-primary: var(--theme-primary, #3b82f6);
}

/* Define theme sets */
[data-theme="dark"] {
  --theme-bg: #0f172a;
  --theme-fg: #f1f5f9;
  --theme-primary: #60a5fa;
}

[data-theme="midnight"] {
  --theme-bg: #020617;
  --theme-fg: #e2e8f0;
  --theme-primary: #818cf8;
}
```

```html
<div class="bg-background text-foreground">
  <button class="bg-primary text-white">Adapts to current theme</button>
</div>
```

## Animation Libraries

Create reusable animation utilities:

```css
@import "tailwindcss";

@theme {
  --animate-spin: spin 1s linear infinite;
  --animate-ping: ping 1s cubic-bezier(0, 0, 0.2, 1) infinite;
  --animate-bounce: bounce 1s infinite;
  --animate-pulse: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

@keyframes ping {
  75%, 100% {
    transform: scale(2);
    opacity: 0;
  }
}

@keyframes bounce {
  0%, 100% {
    animation-timing-function: cubic-bezier(0.8, 0, 1, 1);
    transform: translateY(-25%);
  }
  50% {
    animation-timing-function: cubic-bezier(0, 0, 0.2, 1);
    transform: translateY(0);
  }
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}
```

## Print Styles

Use the `@variant print` directive:

```css
.print-only {
  @variant screen {
    display: none;
  }

  @variant print {
    display: block;
  }
}
```

Or inline:

```css
.my-element {
  @variant print {
    color: black;
    background: white;
  }
}
```

## Performance Optimization

### Disable Unused Features

v4 automatically does not generate unused utilities thanks to its content scanning.

### Minify Output

The build tool automatically minifies CSS in production. No separate CSS minifier needed.

### Tree-Shaking

Vite's module graph integration ensures only used classes are generated:

```typescript
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [tailwindcss()],
  build: {
    // Tailwind v4 automatically optimizes
  },
});
```

## Browser Compatibility

Tailwind CSS v4 targets modern browsers:

- **Chrome/Edge:** 111+
- **Firefox:** 128+
- **Safari:** 16.4+

Automatic transpilation for:
- `oklch()` colors
- CSS nesting
- Modern media queries
- `@property` declarations
- `color-mix()` function

## Quick Reference Cheat Sheet

```css
/* Import */
@import "tailwindcss";

/* Global options */
@import "tailwindcss" prefix(tw);
@import "tailwindcss" important;

/* Theme */
@theme {
  --color-*: <value>;
  --font-*: <value>;
  --breakpoint-*: <value>;
  --spacing-*: <value>;
  --shadow-*: <value>;
  --radius-*: <value>;
  --animate-*: <value>;
  --ease-*: <value>;
}

/* Source control */
@source "./path";
@source not "./path";
@import "tailwindcss" source(none);

/* Custom features */
@utility <name> { /* styles */ }
@custom-variant <name> (<selector>);
@plugin "<package-name>";
@config "./path/to/config.js";

/* Variant in CSS */
.my-element {
  @variant hover {
    /* styles */
  }
}
```

## References

- [Tailwind CSS v4 Documentation](https://tailwindcss.com/docs)
- [Tailwind CSS v4 Upgrade Guide](https://tailwindcss.com/docs/upgrade-guide)
- [Tailwind CSS v4 GitHub](https://github.com/tailwindlabs/tailwindcss)
- [Automatic Upgrade Tool](https://github.com/tailwindlabs/upgrade)