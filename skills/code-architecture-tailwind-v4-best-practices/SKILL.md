---
name: code-architecture-tailwind-v4-best-practices
description: Guides Tailwind CSS v4 patterns for buttons and components. Use this skill when creating components with variants, choosing between CVA/tailwind-variants, or configuring Tailwind v4's CSS-first approach.
---

# Tailwind CSS v4 Best Practices

Use Tailwind utilities first.
Abstract only when variants justify it.

## When to Use

- Building Tailwind v4 components.
- Choosing utilities, CVA, or tailwind-variants.
- Creating button or card variants.
- Setting Tailwind v4 theme tokens.
- Migrating Tailwind v3 patterns.

## Goal

Keep styling local, explicit, accessible, and easy to change.

## Rules

- Use utility classes directly for simple components.
- Use CVA when a component has 3+ variants and needs type-safe props.
- Use tailwind-variants for slots, compound parts, or complex design systems.
- Avoid `@apply` for component styles.
- Use `@theme` for design tokens.
- Use data attributes for component state.
- Keep one styling approach per component family.
- Preserve accessibility on interactive elements.

## Tailwind v4 Setup

```css
@import "tailwindcss";

@theme {
  --color-brand-primary: oklch(0.65 0.24 354.31);
  --font-sans: "Inter", sans-serif;
  --radius-button: 0.5rem;
}
```

## Decision Guide

- Pure utilities: 1-2 variants, simple component, no shared API needed.
- CVA: 3+ variants, type-safe props, button-like component.
- tailwind-variants: slots, responsive variants, component composition.
- Custom `@utility`: rare project-specific utility.
- `@apply`: avoid unless project convention requires it.

## Component Rules

- Keep base layout classes obvious.
- Put state in `data-*` attributes when it affects styling.
- Use `disabled`, `aria-disabled`, and `aria-busy` correctly.
- Accept `className` only when extension is intended.
- Merge classes with existing project helper, usually `cn`.
- Do not hide important design choices behind unclear helpers.

## Migration Notes

- `shadow-sm` became `shadow-xs`.
- `rounded-sm` became `rounded-xs`.
- `bg-opacity-50` becomes `bg-black/50`.
- `bg-gradient-to-r` becomes `bg-linear-to-r`.
- `border` now uses `currentColor`.
- `ring` now uses `currentColor`; use explicit ring width and color.

## Flow

1. Check existing component style patterns.
2. Count variants and slots.
3. Pick utilities, CVA, or tailwind-variants.
4. Add tokens through `@theme` when needed.
5. Model state with attributes.
6. Verify responsive behavior and accessibility.

## References

- [Tailwind CSS v4 Docs](https://tailwindcss.com/docs)
- [CVA (class-variance-authority)](https://cva.style/docs)
- [Tailwind Variants](https://www.tailwind-variants.org/)
- [shadcn/ui](https://ui.shadcn.com/)

## Output

```md
## Tailwind v4 Decision
- Approach: [utilities/CVA/tailwind-variants]
- Reason: [variant count, slots, or project pattern]
- Tokens: [added or none]
- Accessibility: [states and labels checked]
- Migration notes: [v3 changes or none]
```
