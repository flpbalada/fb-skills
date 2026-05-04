# Tailwind v4 Framework-Specific Setup

Installation and configuration examples for popular frameworks.

## Next.js (App Router)

```bash
npm install tailwindcss@latest @tailwindcss/postcss@latest
```

**`postcss.config.mjs`:**

```javascript
export default {
  plugins: {
    "@tailwindcss/postcss": {},
  },
};
```

**`app/globals.css`:**

```css
@import "tailwindcss";

@theme {
  --font-sans: var(--font-inter), system-ui, sans-serif;
}
```

**`app/layout.tsx`:**

```typescript
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ variable: "--font-inter" });

export const metadata: Metadata = {
  title: "My App",
  description: "Built with Tailwind v4",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.variable}>{children}</body>
    </html>
  );
}
```

## Next.js (Pages Router)

**`pages/_app.tsx`:**

```typescript
import '../styles/globals.css';
import type { AppProps } from 'next/app';

export default function App({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />;
}
```

**`styles/globals.css`:**

```css
@import "tailwindcss";

@theme {
  /* Your theme */
}
```

## React (Create React App)

```bash
npm install tailwindcss@latest @tailwindcss/postcss@latest
```

**`craco.config.js`:**

```javascript
module.exports = {
  style: {
    postcss: {
      plugins: {
        "@tailwindcss/postcss": {},
      },
    },
  },
};
```

**`src/index.css`:**

```css
@import "tailwindcss";

@theme {
  /* Your theme */
}
```

## Vue 3 (Vite)

```bash
npm install tailwindcss@latest @tailwindcss/vite@latest
```

**`vite.config.ts`:**

```typescript
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

export default defineConfig({
  plugins: [vue(), tailwindcss()],
});
```

**`src/style.css`:**

```css
@import "tailwindcss";

@theme {
  /* Your theme */
}
```

**`src/main.ts`:**

```typescript
import { createApp } from "vue";
import App from "./App.vue";
import "./style.css";

createApp(App).mount("#app");
```

## SvelteKit

```bash
npm install tailwindcss@latest @tailwindcss/vite@latest
```

**`vite.config.ts`:**

```typescript
import { sveltekit } from "@sveltejs/kit/vite";
import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  plugins: [sveltekit(), tailwindcss()],
});
```

**`src/app.css`:**

```css
@import "tailwindcss";

@theme {
  /* Your theme */
}
```

**`src/routes/+layout.svelte`:**

```svelte
<script>
  import '../app.css';
</script>

<slot />
```

## Quick Reference

| Framework     | Plugin                    | CSS Location          |
| ------------- | ------------------------- | --------------------- |
| Next.js       | `@tailwindcss/postcss`    | `app/globals.css`     |
| React (CRA)   | `@tailwindcss/postcss`    | `src/index.css`       |
| Vue 3         | `@tailwindcss/vite`       | `src/style.css`       |
| SvelteKit     | `@tailwindcss/vite`       | `src/app.css`         |
| Standalone    | `@tailwindcss/cli`        | Any `.css` file       |